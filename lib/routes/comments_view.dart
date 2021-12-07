import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class CommentsView extends StatefulWidget {
  const CommentsView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  @override
  Widget build(BuildContext context) {
    print("CommentsView build is called.");

    setCurrentScreen(widget.analytics, "Comments View", "commentsView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "My Comments",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
