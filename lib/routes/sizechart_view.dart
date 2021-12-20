import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class SizeChartView extends StatefulWidget {
  const SizeChartView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SizeChartViewState createState() => _SizeChartViewState();
}

class _SizeChartViewState extends State<SizeChartView> {

  DBService db = DBService();

  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    print("SizeChartView build is called.");

    setCurrentScreen(widget.analytics, "Sizechart View", "sizechartView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Product Page",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isBookmarked) {
                  db.unBookmarkProduct(
                      "MFR2EFaE6AezehbiIRdZGR4AHS82", "Ba1PWE2AAcz373xRC2GH");
                } else {
                  db.bookmarkProduct("MFR2EFaE6AezehbiIRdZGR4AHS82", "Ba1PWE2AAcz373xRC2GH");
                }

                isBookmarked = !isBookmarked;
              });
            },
            icon: isBookmarked ? const Icon(
              Icons.bookmark,
              color: AppColors.appBarElementColor,
            )
                : const Icon(
              Icons.bookmark_border,
              color: AppColors.appBarElementColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: const [
                        // Product Image
                        // Product Name
                        // Attributes or codenames
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        // Brand Logo (Image)
                        // Location
                        // Rating (As a star representation)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "1300₺",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "900₺",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "30% Off",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  // Quantity Selector
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')));
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/description");
                      },
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
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
                      onPressed: () {},
                      child: const Text(
                        "Size Chart",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
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
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/reviews");
                      },
                      child: const Text(
                        "Reviews",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
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
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(13.0),
                      color:  Colors.white,
                      height: 230.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12,),
                          const Text(
                            "Size Chart",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SingleChildScrollView(
                              child: Column(
                                children: const [

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 6,),
    );
  }
}
