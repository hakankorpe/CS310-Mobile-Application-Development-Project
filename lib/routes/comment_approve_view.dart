import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class CommentApproveView extends StatefulWidget {
  const CommentApproveView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CommentApproveViewState createState() => _CommentApproveViewState();
}

class _CommentApproveViewState extends State<CommentApproveView> {
  @override
  Widget build(BuildContext context) {
    print("CommentApproveView build is called.");

    setCurrentScreen(widget.analytics, "Comment Approve View", "commentApproveView");

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
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/sold");
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
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    child: const Text(
                      "Comments",
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
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
