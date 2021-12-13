import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class OrdersView extends StatefulWidget {
  const OrdersView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {

  int countOrders = 0;

  @override
  Widget build(BuildContext context) {
    print("OrdersView build is called.");

    setCurrentScreen(widget.analytics, "Orders View", "ordersView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "My Past Orders",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              countOrders == 0 ? Center(
                  child: Column(
                    children: const [
                      Text(
                        "No purchase history!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Dimen.sizedBox_15,),
                      Text(
                        "Check back after your next shopping experience!",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              ) : Container(

              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
