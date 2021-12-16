import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/ui/onsale_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnSaleView extends StatefulWidget {
  const OnSaleView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OnSaleViewState createState() => _OnSaleViewState();
}

class _OnSaleViewState extends State<OnSaleView> {

  StorageService storage = StorageService();
  DBService db = DBService();

  List? _onSaleProducts = [];
  int countOnSale = 1;



  @override
  Widget build(BuildContext context) {
    print("OnSaleView build is called.");
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Onsale View", "onsaleView");

    db.getProductsOnSale(user!.uid).then((value) {
      _onSaleProducts = value;
      if (_onSaleProducts != null && countOnSale > 0) setState(() {
        countOnSale = _onSaleProducts!.length;
      });
    });

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
            mainAxisAlignment: countOnSale == 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      child: const Text(
                        "On Sale",
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
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/commentApprove");
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
                ],
              ),
              const Divider(thickness: Dimen.divider_2,),
              Column(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  countOnSale == 0
                      ? const Center(
                          child: Text(
                          "You have not put any products on sale yet.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      : SingleChildScrollView(
                        child: Wrap(
                    children: [
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
                        OnSaleTile(product: dummyItem, remove: () {}, applyDiscount: () {}, stockUpdate: () {}, priceUpdate: () {}),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.floatingActionButtonColor,
        onPressed: () {
          Navigator.pushNamed(context, 'addProduct');
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 7,
      ),
    );
  }
}
