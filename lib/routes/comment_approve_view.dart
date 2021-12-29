import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/comment_approve_tile.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentApproveView extends StatefulWidget {
  const CommentApproveView(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CommentApproveViewState createState() => _CommentApproveViewState();
}

class _CommentApproveViewState extends State<CommentApproveView> {

  DBService db = DBService();

  List<CommentApproveTile> _comments = [];
  int countToApprove = 0;

  @override
  Widget build(BuildContext context) {
    print("CommentApproveView build is called.");
    final user = Provider.of<User?>(context);

    setCurrentScreen(
        widget.analytics, "Comment Approve View", "commentApproveView");

    db.getCommentsToApprove(user!.uid).then((value) {
      if (_comments.isEmpty)
        setState(() {
          _comments = value;
          countToApprove = _comments!.length;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: countToApprove == 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
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
              Column(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  countToApprove == 0
                      ? const Center(
                          child: Text(
                          "There are no new comments to approve or deny.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const Divider(
                                thickness: Dimen.divider_2,
                              ),
                              Wrap(
                                children: _comments,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 0,
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
