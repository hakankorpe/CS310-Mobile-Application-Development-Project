import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:cs310_footwear_project/ui/cart_tile.dart';

import 'login_view.dart';

//TODO: Scrollable yapilacak

class CartView extends StatefulWidget {
  const CartView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int countCartItem = 1;
  int age = 1;

  @override
  Widget build(BuildContext context) {
    print("CartView build is called.");
    final user = Provider.of<User?>(context);
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;

    const dummyImageUrl =
        "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=";

    final dummyItem = FootWearItem(
      productName: "wadösldad",
      brandName: "Nike",
      sellerName: "Melinda",
      price: 3.99,
      rating: 4.8,
      reviews: 1000,
    );

    if (user != null) {
      setCurrentScreen(widget.analytics, "Cart View", "cartView");

      return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          elevation: Dimen.appBarElevation,
          title: Text(
            "Shopping Cart",
            style: kAppBarTitleTextStyle,
          ),
          centerTitle: true,
          iconTheme: kAppBarIconStyle,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: countCartItem != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Expanded(flex: 3, child: Text("")),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Product",
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Price",
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Quantity",
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Subtotal",
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      CartTile(product: dummyItem, quantity: 1),
                      CartTile(product: dummyItem, quantity: 2),
                      CartTile(product: dummyItem, quantity: 3),
                      CartTile(product: dummyItem, quantity: 4),
                      CartTile(product: dummyItem, quantity: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                              flex: 3,
                              child: Text("Total Payment:",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          Expanded(
                              flex: 2,
                              child: Text("570" + "₺",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/checkout");
                        },
                        child: Text(
                          "Continue",
                          style: kButtonDarkTextStyle,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                    "Your cart is empty!",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          index: 0,
        ),
      );
    } else {
      return LoginView(
        observer: observer,
        analytics: analytics,
      );
    }
  }
}
