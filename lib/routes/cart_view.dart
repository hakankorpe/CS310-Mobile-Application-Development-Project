import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
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
  StorageService storage = StorageService();
  DBService db = DBService();
  CollectionReference reference = DBService().cartCollection;
  StreamSubscription<DocumentSnapshot>? streamSub;
  User? user;
  bool firstTime = true;

  List<CartTile> _cartProducts = [];
  int get countCartItem => _cartProducts.length;
  double cartTotal = 0;
  //int age = 1;

  double calculateCartTotal() {
    double total = 0;

    for (int i = 0; i < _cartProducts.length; i++)
      total += (_cartProducts[i].product.price *
          (1 - _cartProducts[i].product.discount!) *
          _cartProducts[i].quantity!);

    return total;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (streamSub != null) streamSub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print("CartView build is called.");
    user = Provider.of<User?>(context);
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;

    setCurrentScreen(widget.analytics, "Cart View", "cartView");

    if (user != null) {
      if (_cartProducts.isEmpty && firstTime) {
        firstTime = false;
        streamSub = db.cartCollection
            .doc(user!.uid)
            .snapshots()
            .listen((DocumentSnapshot documentSnapshot) {
          print(documentSnapshot.data());
          db
              .getCartItemsFromProductIDs(
                  documentSnapshot.data() as Map<String, dynamic>, user!.uid)
              .then((value) {
            if (value.isNotEmpty || _cartProducts.isNotEmpty) {
              if (mounted) {
                setState(() {
                  _cartProducts = value;
                  cartTotal = calculateCartTotal();
                });
              }
            }
          });
        });
      }

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
                        height: 0,
                      ),
                      const SizedBox(
                        height: 16,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Price",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Quantity",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Subtotal",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        thickness: 1.5,
                        height: 0,
                      ),
                      Wrap(
                        children: _cartProducts,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text("Total Payment:",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          const Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          const Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          const Expanded(
                              flex: 2,
                              child: Text("", textAlign: TextAlign.center)),
                          Expanded(
                              flex: 2,
                              child: Text("${cartTotal.toStringAsFixed(2)}₺",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                          Navigator.pushNamed(
                            context,
                            "/checkout",
                            arguments: {
                              "cart-products": _cartProducts,
                              "cart-total": cartTotal
                            },
                          );
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
