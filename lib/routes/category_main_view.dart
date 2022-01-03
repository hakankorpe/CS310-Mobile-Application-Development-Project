import 'package:cs310_footwear_project/components/category_item.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class CategoryMainView extends StatefulWidget {
  const CategoryMainView(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CategoryMainViewState createState() => _CategoryMainViewState();
}

class _CategoryMainViewState extends State<CategoryMainView> {
  @override
  Widget build(BuildContext context) {
    print("CategoryMainView build is called.");

    setCurrentScreen(
        widget.analytics, "Category Main View", "categoryMainView");

    const dummyImageUrl =
        "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=";

    final dummyItem = CategoryItem(
      imageUrl: dummyImageUrl,
      CategoryName: "Sneakers",
    );

    List<String> categoryImageLinks = <String>[
      "https://e7.pngegg.com/pngimages/248/618/png-clipart-knee-high-boot-combat-boot-shoe-thigh-high-boots-knee-high-boot-men-zipper-leather.png",
      "https://e7.pngegg.com/pngimages/111/504/png-clipart-oxford-shoe-brogue-shoe-derby-shoe-formal-wear-suit-brown-leather.png",
      "https://image.similarpng.com/thumbnail/2020/09/Beige-high-heel-shoes-isolated-on-transparent-bakground-PNG.png",
      "https://w7.pngwing.com/pngs/45/339/png-transparent-slip-on-shoe-suede-walking-others-brown-leather-suede.png",
      "https://w7.pngwing.com/pngs/369/761/png-transparent-monk-shoe-slip-on-shoe-shoemaking-derby-shoe-thai-monk-brown-leather-heel.png",
      "https://e7.pngegg.com/pngimages/841/545/png-clipart-oxford-shoe-leather-walking-men-carved-bullock-outdoor-shoe-sneakers.png",
      "https://w7.pngwing.com/pngs/834/435/png-transparent-flip-flops-slipper-beach-sandal-fashion-outdoor-shoe-flip-flops.png",
      "https://png2.cleanpng.com/sh/b2b2574c39c091d50e79f0aa9748d405/L0KzQYm3VsA1N5RtfZH0aYP2gLBuTgNtcaF1feQ2Y3zyd376iP9mNaRxgdZuLXbyf8XAhfFzNZl0jeVuLYPvecH3hgJ0NWZnSac5YkS6QIO6VvUzNmU7TqM7MkizQYa5WMExPWgAUaI5OUGxgLBu/kisspng-slipper-clog-shoe-slide-footwear-house-slippers-5b150b470236e2.4661228015281057990091.png",
      "https://w7.pngwing.com/pngs/379/798/png-transparent-sneakers-shoe-nike-high-heeled-footwear-adidas-nike-sports-shoes-white-sport-outdoor-shoe.png",
      "https://w7.pngwing.com/pngs/579/509/png-transparent-nike-tiempo-football-boot-shoe-leather-nike-white-sport-orange.png",
    ];

    List<String> categoryNames = <String>[
      "Boots",
      "Derby",
      "High-Heeled",
      "Loafers",
      "Monk",
      "Oxford",
      "Sandals",
      "Slippers",
      "Sneakers",
      "Fitness & Sports",
    ];

    final categoryItems = List.generate(
        categoryNames.length,
        (index) => CategoryItem(
            imageUrl: categoryImageLinks[index],
            CategoryName: categoryNames[index]));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Categories",
          style: kAppBarTitleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.appBarElementColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicWidth(
              child: Wrap(
                spacing: 15.0,
                runSpacing: 25.0,
                alignment: WrapAlignment.center,
                children: categoryItems,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
    );
  }
}
