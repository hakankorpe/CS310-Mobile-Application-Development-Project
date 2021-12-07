import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class CategorySelectedView extends StatefulWidget {
  const CategorySelectedView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CategorySelectedViewState createState() => _CategorySelectedViewState();
}

class _CategorySelectedViewState extends State<CategorySelectedView> {
  @override
  Widget build(BuildContext context) {
    print("CategorySelectedView build is called.");

    setCurrentScreen(widget.analytics, "Category Selected View", "categorySelectedView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
    );
  }
}
