import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SoldView extends StatefulWidget {
  const SoldView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SoldViewState createState() => _SoldViewState();
}

class _SoldViewState extends State<SoldView> {

  StorageService storage = StorageService();
  DBService db = DBService();

  List? _soldProducts = [];
  int countSold = 0;

  @override
  Widget build(BuildContext context) {
    print("SoldView build is called.");
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Sold View", "soldView");

    db.getProductsSold(user!.uid).then((value) {
      _soldProducts = value;
      if (_soldProducts != null) setState(() {
        countSold = _soldProducts!.length;
      });
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
            "My Products",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    child: const Text(
                      "On Sale",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/onSale");
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    child: const Text(
                      "Sold",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    child: const Text(
                      "Comments",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/commentApprove");
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                countSold == 0
                    ? const Center(
                    child: Text(
                      "You have not sold any products yet.",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ))
                    : Padding(
                  padding: Dimen.regularPadding,
                  child: Column(),
                ),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
