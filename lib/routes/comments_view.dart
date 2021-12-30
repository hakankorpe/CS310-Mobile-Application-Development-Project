import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/comments_tile.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsView extends StatefulWidget {
  const CommentsView(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {

  DBService db = DBService();

  List<CommentsTile> _comments = [];
  int commentCount = 0;

  StreamSubscription<QuerySnapshot>? streamSub;
  bool firstTime = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (streamSub != null) streamSub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print("CommentsView build is called.");
    final user = Provider.of<User?>(context);

    setCurrentScreen(widget.analytics, "Comments View", "commentsView");

    if (_comments.isEmpty && firstTime) {
      firstTime = false;
      streamSub = db.reviewCollection
          .where("user-id", isEqualTo: user!.uid)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        print(querySnapshot.docChanges.map((e) => e.doc.data()));
        db.getCommentsOfUser(user!.uid).then((value) {
          setState(() {
            _comments = value;
            commentCount = _comments!.length;
          });
        });
      });
    }

    db.getCommentsOfUser(user!.uid).then((value) {
      if (_comments.isEmpty)
        setState(() {
          _comments = value;
          commentCount = _comments!.length;
        });
    });

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
            mainAxisAlignment: commentCount == 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
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
                  : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: Dimen.divider_2,
                        height: 0,
                      ),
                      Wrap(
                        children: _comments,
                      ),
                    ],
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
