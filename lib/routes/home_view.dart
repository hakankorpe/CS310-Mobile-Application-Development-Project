import 'package:cs310_footwear_project/components/footwear_display.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _message = "";

  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'CS310_Test', parameters: <String, dynamic>{
      "string": "myString",
      "int": 12,
      "long": 123456789,
      "bool": true,
    });
    setMessage("setLogEvent succeeded.");
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: "Home View",
      screenClassOverride: "HomeView",
    );
    setMessage("setCurrentScreen succeeded.");
  }

  Future<void> _setUserId() async {
    await widget.analytics.setUserId("sayanarman");
    setMessage("setUserId succeeded.");
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build is called.");

    setCurrentScreen(widget.analytics, "Home View", "homeView");

    const dummyImageUrl =
        "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=";

    const dummyItem = FootWearItem(
      imageUrl: dummyImageUrl,
      brandName: "Nike",
      sellerName: "Melinda",
      price: 3.99,
      rating: 4.8,
      reviews: 1000,
    );

    const dummyItemList = [dummyItem, dummyItem, dummyItem, dummyItem];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Welcome to FootWear",
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
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimen.regularMargin),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FootWearDisplay(
                  itemList: dummyItemList, displayName: "Featured"),
              const FootWearDisplay(
                  itemList: dummyItemList, displayName: "Discounts"),
              const FootWearDisplay(
                  itemList: dummyItemList, displayName: "Just For You"),
            ]),
      ),
      bottomNavigationBar: NavigationBar(
        index: 0,
      ),
    );
  }
}
