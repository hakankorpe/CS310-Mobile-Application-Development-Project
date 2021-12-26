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

  List selectedFootSize = [];
  double selectedRating = 0.0;

  List<FootWearItem> foundItems = [];
  List<UserTile> foundUsers = [
    UserTile(
      displayName: "Deneme",
      rating: 4.3,
      username: "deneme",
      userID: "7BnDwbxk85Svj2yw9I1vjfVDgfT2",
    )
  ];

  Map<String, dynamic> filters = {};
  dynamic sorter;

  //FilterHelpers
  dynamic brandCategoryFilter(List<String> brandCategoryNames) {
    return (value) => brandCategoryNames.contains(value);
  }

  dynamic priceFilter([double minimum = 0, double maximum = double.infinity]) {
    return (value) => (value >= minimum) && (value <= maximum);
  }

  dynamic ratingFilter([double minimum = 0, double maximum = 5.0]) {
    return priceFilter(minimum, min(maximum, 5));
  }

  //SorterHelpers
  dynamic sorterHelper(String property, [bool reverse = false]) {
    return (Map<String, dynamic> a, Map<String, dynamic> b) {
      int result = a[property].compareTo(b[property]);
      return result;
    };
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
                            foundItems = [];
                          });
                        }
                        if (_formKey.currentState!.validate()) {
                          sorter = sorterHelper("brand-name");
                          filters = {
                            "current-price": priceFilter(10, 25),
                            "rating": ratingFilter(2, 4)
                          };
                          () async {
                            final resultProduct = await DBService()
                                .advancedSearchProduct(searchValue, {}, sorter);
                            final resultUsers =
                                await DBService().basicSearchUser(searchValue);
                            setState(() {
                              foundItems = resultProduct;
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
                      setState(() {
                        prFilterSelected = selected;
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
                            setState(() {
                              brandFilterSelected = selected;
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
                        title: 'Foot Size',
                        onChanged: (value) {
                          selectedRating = value as double;
                          print(value);
                          filters["rating"] = ratingFilter(selectedRating);
                        },
                      );
                      setState(() {
                        ratingFilterSelected = selected;
                      });
                    },
                  ),
                  fsFilterSelected
                      ? InputChip(
                    avatar: Icon(Icons.coffee),
                    label: Text('Foot Size'),
                    selected: fsFilterSelected,
                    deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white70,
                    showCheckmark: false,
                    onDeleted: () {
                      setState(() {
                        fsFilterSelected = !fsFilterSelected;
                      });
                    },
                  )
                      : InputChip(
                    avatar: Icon(Icons.coffee),
                    label: Text('Foot Size'),
                    selected: fsFilterSelected,
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      showMaterialCheckboxPicker(
                        context: context,
                        title: 'Foot Size',
                        onChanged: (value) {
                              selectedFootSize = value;
                            print(value);
                            filters["rating"] = ratingFilter(value as double);
                            },
                        items: [36, 37, 38, 39, 40, 41, 42, 43, 44],
                        selectedItems: selectedFootSize,
                      );
                      print(selectedFootSize);
                      setState(() {
                        fsFilterSelected = selected;
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
                Row(
                  children: const [
                    Text("Add Filters Button Later On"),
                  ],
                ),
              if (isSearched != false)
                const SizedBox(
                  height: 10,
                ),
              if (isSearched != false)
                Text(
                  "${foundItems.length} Results for \"Nike\" in products",
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
                  "${foundUsers.length} Results for \"Nike\" in sellers",
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
