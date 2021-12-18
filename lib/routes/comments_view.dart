import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/comments_tile.dart';
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

  int commentCount = 1;

  @override
  Widget build(BuildContext context) {

    const dummyImageUrl =
        "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=";

    final dummyItem = FootWearItem(
      imageUrl: dummyImageUrl,
      brandName: "Nike",
      sellerName: "Melinda",
      price: 3.99,
      rating: 4.8,
      reviews: 1000,
      discount: 0.25,
      stockCount: 27,
    );

    print("CommentsView build is called.");

    setCurrentScreen(widget.analytics, "Comments View", "commentsView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "My Reviews",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: commentCount == 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commentCount == 0
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "No Reviews!",
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
                    "You can give reviews for your products in previous orders.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : SingleChildScrollView(
                child: Wrap(
                  children: [
                    const Divider(thickness: Dimen.divider_2,),
                    CommentsTile(product: dummyItem),
                    CommentsTile(product: dummyItem),
                    CommentsTile(product: dummyItem),
                    CommentsTile(product: dummyItem),
                    CommentsTile(product: dummyItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
