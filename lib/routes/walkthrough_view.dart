import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:cs310_footwear_project/services/analytics.dart';

class WalkthroughView extends StatefulWidget {
  const WalkthroughView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  static const String id = "/splashScreen";

  @override
  _WalkthroughViewState createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends State<WalkthroughView> {

  int currentPage = 0;
  int totalPage = 4;

  List<String> headings = [
    "Welcome to Footwear",
    "Discover",
    "Pay Online",
    "Enjoy Your Shopping",
  ];

  List<String> imageURLs = [
    "https://previews.123rf.com/images/llesia/llesia1607/llesia160700013/59400494-concept-online-shopping-and-e-commerce-icons-for-mobile-marketing-hand-holding-smart-phone-flat-desi.jpg",
    "https://media.istockphoto.com/photos/great-sneaker-picture-id1079117394?k=20&m=1079117394&s=612x612&w=0&h=rUuc5v_-8uckfumKljOD0RkgfPtRWcV0c8n2MI1BS6w=",
    "https://optinmonster.com/wp-content/uploads/2019/10/featured-image-mobile-payment-solutions.png",
    "https://assets.justinmind.com/wp-content/uploads/2019/10/shopping-cart-design.png",
  ];

  List<String> captions = [
    "A new experience for the foot product shopping",
    "Explore world's top brands in foot products ",
    "Fast online bank processing, finish your order in seconds",
    "Start the full experience of Footwear now",
  ];

  void nextPage() {
    if (currentPage < totalPage - 1) {
      setState(() {
        currentPage += 1;
      });
    }
    else {
      Navigator.popAndPushNamed(context, "/home");
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    setCurrentScreen(widget.analytics, "Walkthrough View", "walkthroughView");
    
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
      ),
      body: SafeArea(
        child: Padding(
          padding: Dimen.regularPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                    headings[currentPage],
                  style: kHeadingTextStyle,
                ),
              ),
              Image(
                image: NetworkImage(
                  imageURLs[currentPage],
                ),
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  captions[currentPage],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: previousPage,
                      child: Text(
                          currentPage!=0 ? 'Back':'',
                        style: kSelectedViewButtonTextStyle,
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: currentPage!=0 ? Colors.black:Colors.white,
                        side: BorderSide(
                          color: currentPage!=0 ? Colors.black:Colors.white,
                          width: 0,
                        ),
                      ),
                  ),
                  const Spacer(),
                  DotsIndicator(
                      dotsCount: totalPage,
                      position: currentPage.toDouble(),
                      decorator: const DotsDecorator(
                        activeColor: Colors.black,
                      ),
                  ),
                  //Text("$currentPage/$totalPage"),
                  const Spacer(),
                  OutlinedButton(
                      onPressed: nextPage,
                      child: Text(
                        currentPage!=totalPage-1 ? 'Next':'Start',
                        style: kSelectedViewButtonTextStyle,
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
