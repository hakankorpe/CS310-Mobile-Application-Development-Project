import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
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

  DBService db = DBService();
  String? categoryName;
  List<FootWearItem> allProducts = [];

  @override
  Widget build(BuildContext context) {
    print("CategorySelectedView build is called.");

    //Get arguments passed by navigator
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) categoryName = arguments["categoryName"];
    if (categoryName != null) {
      db.getCategoryProducts(categoryName!).then((value) {
        allProducts = value;
        setState(() {

        });
      });
    }

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
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: allProducts.isNotEmpty ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // TODO ADD FILTER BUTTONS
              Wrap(
                children: allProducts,
                spacing: 15.0,
                runSpacing: 25.0,
                alignment: WrapAlignment.center,
              ),
            ],
          ) : Column(
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
