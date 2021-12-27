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

  List<FootWearItem> allItems = [];
  List<String> wantedProducts = [];

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

  dynamic priceFilter([double minimum = 0, double maximum = double.infinity]) {
    return (value) => (value >= minimum) && (value <= maximum);
  }

  dynamic ratingFilter([double minimum = 0, double maximum = double.infinity]) {
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
  dynamic sorterHelper(String property, [bool reverse = false]) {
    return (Map<String, dynamic> a, Map<String, dynamic> b) {
      int result = a[property].compareTo(b[property]);
      return (reverse == false) ? result : -result;
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
                            allItems = [];
                          });
                        }
                        if (_formKey.currentState!.validate()) {
                          sorter = sorterHelper("product-name");
                          filters = {};
                          () async {
                            final resultProducts = await DBService()
                                .basicSearchProduct(searchValue);

                            final resultUsers =
                                await DBService().basicSearchUser(searchValue);

                            final resultFootwearList = await Future.wait(
                                resultProducts.map((e) async =>
                                    await DBService().returnFootwearItem(e)));

                            setState(() {
                              wantedProducts = applyFilterSort(resultProducts);
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
