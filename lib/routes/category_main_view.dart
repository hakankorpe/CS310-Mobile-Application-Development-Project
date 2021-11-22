import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class CategoryMainView extends StatefulWidget {
  const CategoryMainView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CategoryMainViewState createState() => _CategoryMainViewState();
}

class _CategoryMainViewState extends State<CategoryMainView> {
  @override
  Widget build(BuildContext context) {
    print("CategoryMainView build is called.");
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
            "Categories",
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
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
    );
  }
}
