import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class CategorySelectedView extends StatefulWidget {
  CategorySelectedView({Key? key, required this.analytics, required this.observer,}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String? categoryName;

  @override
  _CategorySelectedViewState createState() => _CategorySelectedViewState();
}

class _CategorySelectedViewState extends State<CategorySelectedView> {

  String? categoryName;

  @override
  Widget build(BuildContext context) {
    print("CategorySelectedView build is called.");

    //Get arguments passed by navigator
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) categoryName = arguments["categoryName"];

    setCurrentScreen(widget.analytics, "Category Selected View", "categorySelectedView");

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
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
    );
  }
}
