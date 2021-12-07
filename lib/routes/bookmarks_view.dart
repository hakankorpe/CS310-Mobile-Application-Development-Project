import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class BookmarksView extends StatefulWidget {
  const BookmarksView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _BookmarksViewState createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  @override
  Widget build(BuildContext context) {
    print("BookmarksView build is called.");

    setCurrentScreen(widget.analytics, "Bookmarks View", "bookmarksView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "My Bookmarks",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
