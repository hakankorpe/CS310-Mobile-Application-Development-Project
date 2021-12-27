import 'dart:math';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/ui/user_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _formKey = GlobalKey<FormState>();
  String searchValue = "";
  bool get isSearched => searchValue.isNotEmpty;
  bool genderFilterSelected = false;
  bool prFilterSelected = false;
  bool brandFilterSelected = false;
  bool ratingFilterSelected = false;
  bool fsFilterSelected = false;
  bool categoryFilterSelected = false;
  bool sortSelected = false;

  List selectedFootSize = [];
  double selectedRating = 0.0;

  List<FootWearItem> allItems = [];
  List<String> get wantedProducts => applyFilterSort(allItemsMap);

  Iterable<Map<String, dynamic>> allItemsMap = [];

  List<FootWearItem> get foundItems => wantedProducts
      .map((productToken) => allItems
          .firstWhere((element) => element.productToken == productToken))
      .toList();

  List<UserTile> foundUsers = [];

  Map<String, dynamic> filters = {};
  dynamic sorter;

  //FilterHelpers
  dynamic brandCategoryFilter(List<String> brandCategoryNames) {
    return (value) => brandCategoryNames.contains(value);
  }

  dynamic footSizeFilter(List<double> brandCategoryNames) {
    return (value) => brandCategoryNames.contains(value);
  }

  dynamic priceFilter([double minimum = 0, double maximum = double.infinity]) {
    return (value) => (value >= minimum) && (value <= maximum);
  }

  dynamic ratingFilter([double minimum = 0, double maximum = 5.0]) {
    return priceFilter(minimum, min(maximum, 5));
  }

  List<String> applyFilterSort(Iterable<Map<String, dynamic>> original) {
    Iterable<Map<String, dynamic>>? newIterable;

    filters.forEach((key, value) {
      newIterable =
          (newIterable ?? original).where((element) => value(element[key]));
    });

    var newList = (newIterable ?? original)!.toList();
    newList.sort(sorter);
    return newList.map((e) => e["product-id"] as String).toList();
  }

  //SorterHelpers
  dynamic sorterHelper(String property) {
    return (Map<String, dynamic> a, Map<String, dynamic> b) {
      int result = a[property].compareTo(b[property]);
      return (reverse == false) ? result : -result;
    };
  }
  bool reverse = true;
  bool reverseSelected = false;

  List<String> categoryNames = <String>[
    "Boots",
    "Derby",
    "High-Heeled",
    "Loafers",
    "Monk",
    "Oxford",
    "Sandals",
    "Slippers",
    "Sneakers",
    "Fitness & Sports",
  ];

  List<String> brandNames = [];
  List<double> footSizes = [];

  @override
  void initState() {
    super.initState();
    DBService().getBrandNames().then((value) {
      brandNames = value;
    });
    DBService().getFootSizes().then((value) {
      footSizes = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("SearchView build is called.");

    setCurrentScreen(widget.analytics, "Search View", "searchView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Search",
          style: kAppBarTitleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.appBarElementColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimen.regularMargin),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (!isSearched) {
                          setState(() {
                            allItems = [];
                          });
                        }
                        if (_formKey.currentState!.validate()) {
                          sorter = sorterHelper("product-name");
                          filters =  {};
                          () async {
                            final resultProducts = await DBService()
                                .basicSearchProduct(searchValue);

                            final resultUsers =
                                await DBService().basicSearchUser(searchValue);

                            final resultFootwearList = await Future.wait(
                                resultProducts.map((e) async =>
                                    await DBService().returnFootwearItem(e)));

                            setState(() {
                              allItemsMap = resultProducts;
                              allItems = resultFootwearList;
                              foundUsers = resultUsers;
                            });
                          }();
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      validator: (value) => (value?.isEmpty ?? false)
                          ? "Please enter some text"
                          : null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) => searchValue = value,
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.5,
                color: Colors.black38,
              ),
              if (allItemsMap.isNotEmpty) Row(
                children: [
                  sortSelected
                      ? InputChip(
                    avatar: Icon(Icons.sort),
                    label: Text('Sort'),
                    selected: sortSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      //filters.remove("current-price");
                      setState(() {
                        sortSelected = !sortSelected;
                        if (reverseSelected) reverseSelected = !reverseSelected;
                      });
                    },
                  )
                      : InputChip(
                    avatar: Icon(Icons.sort),
                    label: Text('Sort'),
                    selected: sortSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialScrollPicker(
                          context: context,
                          title: "Choose a sort option",
                          items: allItemsMap.first.keys.toList(),
                          selectedItem: 1,
                          onChanged: (value) {
                            sorter = sorterHelper(value.toString(),);
                          }
                      ).then((value) {
                        setState(() {
                          sortSelected = selected;
                        });
                      });
                    },
                  ),
                  const SizedBox(width: Dimen.sizedBox_5,),
                  if (sortSelected) InputChip(
                    //avatar: Icon(Icons.sort),
                    label: Text('Reverse'),
                    selected: reverseSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onPressed: () {
                      setState(() {
                        reverse = !reverse;
                        reverseSelected = !reverseSelected;
                      });
                    },
                  )
                ],
              ),
              if (allItemsMap.isNotEmpty) Wrap(
                alignment: WrapAlignment.start,
                spacing: 6,
                runSpacing: 6,
                children: [
                  prFilterSelected
                      ? InputChip(
                    avatar: Icon(Icons.money),
                    label: Text('Price Range'),
                    selected: prFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      filters.remove("current-price");
                      setState(() {
                        prFilterSelected = !prFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    avatar: Icon(Icons.money),
                    label: Text('Price Range'),
                    selected: prFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialScrollPicker(
                          context: context,
                          title: "Choose a price range",
                          items: ["0-500₺", "500-1000₺", "1000-1500₺", "1500-2000₺", "2000-...₺"],
                          selectedItem: 1,
                          onChanged: (value) {
                            List<dynamic> priceRange = value.toString().split("₺")[0].split("-");
                            double min = double.parse(priceRange[0]);

                            if (priceRange[1] == "...") {
                              filters["current-price"] = priceFilter(min);
                            }
                            else {
                              double max = double.parse(priceRange[1]);
                              filters["current-price"] = priceFilter(min, max);
                            }
                          }
                      ).then((value) {
                        setState(() {
                          prFilterSelected = selected;
                        });
                      });
                    },
                  ),
                  genderFilterSelected
                      ? InputChip(
                    avatar: Icon(Icons.transgender),
                    label: Text('Gender'),
                    selected: genderFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      setState(() {
                        genderFilterSelected = !genderFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    avatar: Icon(Icons.transgender),
                    label: Text('Gender'),
                    selected: genderFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      setState(() {
                        genderFilterSelected = selected;
                      });
                    },
                  ),
                  brandFilterSelected
                      ? InputChip(
                          avatar: Icon(Icons.label),
                          label: Text('Brand'),
                          selected: brandFilterSelected,
                          deleteIcon: Icon(Icons.cancel),
                          deleteIconColor: Colors.white70,
                          showCheckmark: false,
                          onDeleted: () {
                            filters.remove("brand-name");
                            setState(() {
                              brandFilterSelected = !brandFilterSelected;
                            });
                          },
                        )
                      : InputChip(
                          avatar: Icon(Icons.label),
                          label: Text('Brand'),
                          selected: brandFilterSelected,
                          showCheckmark: false,
                          onSelected: (bool selected) {
                            showMaterialCheckboxPicker(
                                context: context,
                                items: brandNames,
                                title: "Select Brand Names To Filter",
                                onChanged: (List<String> value) {
                                  filters["brand-name"] = brandCategoryFilter(value);
                                }
                            ).then((value) {
                              setState(() {
                                brandFilterSelected = selected;
                              });
                            });
                          },
                        ),
                  ratingFilterSelected
                      ? InputChip(
                    avatar: Icon(Icons.stars),
                    label: Text('Rating'),
                    selected: ratingFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      filters.remove("rating");
                      setState(() {
                        ratingFilterSelected = !ratingFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    avatar: Icon(Icons.stars),
                    label: Text('Rating'),
                    selected: ratingFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialRadioPicker(
                          context: context,
                          items: [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0],
                        title: 'Rating',
                        onChanged: (value) {
                          selectedRating = double.parse(value.toString());
                          print(value);
                          filters["rating"] = ratingFilter(selectedRating);
                        },
                      ).then((value) {
                        setState(() {
                          ratingFilterSelected = selected;
                        });
                      });
                    },
                  ),
                  fsFilterSelected
                      ? InputChip(
                    //avatar: Icon(Icons.coffee),
                    label: Text('Foot Size'),
                    selected: fsFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      filters.remove("foot-size");
                      setState(() {
                        fsFilterSelected = !fsFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    //avatar: Icon(Icons.coffee),
                    label: Text('Foot Size'),
                    selected: fsFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialCheckboxPicker(
                          context: context,
                          items: footSizes,
                          title: "Select Foot Sizes To Filter",
                          onChanged: (List<double> value) {
                            filters["foot-size"] = footSizeFilter(value);
                          }
                      ).then((value) {
                        setState(() {
                          fsFilterSelected = selected;
                        });
                      });
                    },
                  ),
                  categoryFilterSelected
                      ? InputChip(
                    //avatar: Icon(Icons.coffee),
                    label: Text('Category'),
                    selected: categoryFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      filters.remove("category");
                      setState(() {
                        categoryFilterSelected = !categoryFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    //avatar: Icon(Icons.coffee),
                    label: Text('Category'),
                    selected: categoryFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialCheckboxPicker(
                          context: context,
                          items: categoryNames,
                          title: "Select Categories To Filter",
                          onChanged: (List<String> value) {
                            filters["category"] = brandCategoryFilter(value);
                          }
                      ).then((value) {
                        setState(() {
                          categoryFilterSelected = selected;
                        });
                      });
                    },
                  ),
                ],
              ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                Text(
                  "${foundItems.length} Results for $searchValue in products",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                Wrap(
                  spacing: 25.0,
                  runSpacing: 25.0,
                  alignment: WrapAlignment.center,
                  children: foundItems,
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                const Divider(
                  thickness: 1.5,
                  color: Colors.black38,
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                Text(
                  "${foundUsers.length} Results for $searchValue in sellers",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                Wrap(
                  spacing: 25.0,
                  runSpacing: 25.0,
                  alignment: WrapAlignment.center,
                  children: foundUsers,
                ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 1,
      ),
    );
  }
}
