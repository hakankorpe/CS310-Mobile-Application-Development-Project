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
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class CategorySelectedView extends StatefulWidget {
  CategorySelectedView({
    Key? key,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String? categoryName;

  @override
  _CategorySelectedViewState createState() => _CategorySelectedViewState();
}

class _CategorySelectedViewState extends State<CategorySelectedView> {
  DBService db = DBService();
  String? categoryName;

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

  dynamic genderFilter(List<String> genderType) {
    return (value) => genderType.contains(value);
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
  List<String> genders = ["Male", "Female", "Unisex"];

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
    print("CategorySelectedView build is called.");

    //Get arguments passed by navigator
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) categoryName = arguments["categoryName"];
    if (categoryName != null) {
      db
          .getAllCollectionItems(
              db.productCollection.where("category", isEqualTo: categoryName))
          .then((value) {
        allItemsMap = value;
        return Future.wait(
            value.map((e) async => await DBService().returnFootwearItem(e)));
      }).then((value1) {
        allItems = value1;
        setState(() {});
      });
    }

    setCurrentScreen(
        widget.analytics, "Category Selected View", "categorySelectedView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          categoryName!,
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
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: allItems.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // TODO ADD FILTER BUTTONS
                    if (allItems.isNotEmpty)
                      Row(
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
                                      if (reverseSelected)
                                        reverseSelected = !reverseSelected;
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
                                          sorter = sorterHelper(
                                            value.toString(),
                                          );
                                        }).then((value) {
                                      setState(() {
                                        sortSelected = selected;
                                      });
                                    });
                                  },
                                ),
                          const SizedBox(
                            width: Dimen.sizedBox_5,
                          ),
                          if (sortSelected)
                            InputChip(
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
                    if (allItems.isNotEmpty)
                      Wrap(
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
                                        items: [
                                          "0-500₺",
                                          "500-1000₺",
                                          "1000-1500₺",
                                          "1500-2000₺",
                                          "2000-...₺"
                                        ],
                                        selectedItem: 1,
                                        onChanged: (value) {
                                          List<dynamic> priceRange = value
                                              .toString()
                                              .split("₺")[0]
                                              .split("-");
                                          double min =
                                              double.parse(priceRange[0]);

                                          if (priceRange[1] == "...") {
                                            filters["current-price"] =
                                                priceFilter(min);
                                          } else {
                                            double max =
                                                double.parse(priceRange[1]);
                                            filters["current-price"] =
                                                priceFilter(min, max);
                                          }
                                        }).then((value) {
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
                                    filters.remove("gender");
                                    setState(() {
                                      genderFilterSelected =
                                          !genderFilterSelected;
                                    });
                                  },
                                )
                              : InputChip(
                                  avatar: Icon(Icons.transgender),
                                  label: Text('Gender'),
                                  selected: genderFilterSelected,
                                  showCheckmark: false,
                                  onSelected: (bool selected) {
                                    showMaterialCheckboxPicker(
                                        context: context,
                                        items: genders,
                                        title: "Select Gender Type To Filter",
                                        onChanged: (List<String> value) {
                                          filters["gender"] =
                                              genderFilter(value);
                                        }).then((value) {
                                      setState(() {
                                        genderFilterSelected = selected;
                                      });
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
                                      brandFilterSelected =
                                          !brandFilterSelected;
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
                                          filters["brand-name"] =
                                              brandCategoryFilter(value);
                                        }).then((value) {
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
                                      ratingFilterSelected =
                                          !ratingFilterSelected;
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
                                      items: [
                                        0.0,
                                        0.5,
                                        1.0,
                                        1.5,
                                        2.0,
                                        2.5,
                                        3.0,
                                        3.5,
                                        4.0,
                                        4.5,
                                        5.0
                                      ],
                                      title: 'Rating',
                                      onChanged: (value) {
                                        selectedRating =
                                            double.parse(value.toString());
                                        print(value);
                                        filters["rating"] =
                                            ratingFilter(selectedRating);
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
                                          filters["foot-size"] =
                                              footSizeFilter(value);
                                        }).then((value) {
                                      setState(() {
                                        fsFilterSelected = selected;
                                      });
                                    });
                                  },
                                ),
                        ],
                      ),
                    Wrap(
                      children: allItems,
                      spacing: 15.0,
                      runSpacing: 25.0,
                      alignment: WrapAlignment.center,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "No Products for ${categoryName!}!",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: Dimen.sizedBox_15,
                    ),
                    const Text(
                      "Try your chance later on.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
    );
  }
}
