import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/ui/onsale_tile.dart';
import 'package:cs310_footwear_project/ui/order_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {

  DBService db = DBService();

  List<OrderTile> _orders = [];
  int countOrders = 0;

  @override
  Widget build(BuildContext context) {
    print("OrdersView build is called.");
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Orders View", "ordersView");


    db.getOrdersOfUser(user!.uid).then((value) {
      if (_orders.isEmpty)
        setState(() {
          _orders = value;
          countOrders = _orders!.length;
        });
    });

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
            mainAxisAlignment: countOrders == 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              countOrders == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "No purchase history!",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Dimen.sizedBox_15,
                        ),
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
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const Divider(
                            thickness: Dimen.divider_2,
                          ),
                          Wrap(
                            children: _orders,
                          )
                        ],
                      ),
                    ),
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
