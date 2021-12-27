import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/campaigns_tile.dart';
import 'package:cs310_footwear_project/ui/coupons_tile.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/ui/orderUpdates_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  int orderUpdatesCount = 0;
  int campaignsCount = 0;
  int couponsCount = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    setCurrentScreen(widget.analytics, "Notification View", "notificationView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Notifications",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Order Updates",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: Dimen.divider_1_5,
                height: 0,
              ),
              OrderUpdatesTile(notificationDate: "25/12/2021", orderNumber: "124fjfag1745",
                updateMessage: 'Your foot items has been delivered! Enjoy your products!', ),
              OrderUpdatesTile(notificationDate: "26/12/2021", orderNumber: "124fjfag1745",
                updateMessage: 'Your order is packed and ready to be shipped!', ),
              SizedBox(height: Dimen.sizedBox_20,),
              Text(
                  "Campaigns",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: Dimen.divider_1_5,
                height: 0,
              ),
              CampaignTile(notificationDate: "25/12/2021",
                campaignMessage: "Buy 3, Pay 1 on Boots", campaignLastDate: '15/01/2022',),
              CampaignTile(notificationDate: "26/12/2021",
                campaignMessage: "50% Percent Off on Sneakers", campaignLastDate: '21/03/2022',),
              SizedBox(height: Dimen.sizedBox_20,),
              Text(
                  "Coupons",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: Dimen.divider_1_5,
                height: 0,
              ),
              CouponsTile(couponCode: "txfrtyvskjhsvd", couponExpirationDate: "12/21/2022"),
              CouponsTile(couponCode: "txfrtyvskjhsvd", couponExpirationDate: "12/21/2022"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 7,
      ),
    );
  }
}
