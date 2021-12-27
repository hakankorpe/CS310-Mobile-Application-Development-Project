import 'dart:io';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/address_tile.dart';
import 'package:cs310_footwear_project/ui/cart_tile.dart';
import 'package:cs310_footwear_project/ui/checkout_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  DBService db = DBService();

  final _formKey = GlobalKey<FormState>();
  bool _value = false;

  double? cartTotal;
  List<CheckoutTile>? _allCheckoutTiles;

  Future<void> showOrderCompleteDialog(BuildContext context,) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final _formKey = GlobalKey<FormState>();
          bool isIOS = Platform.isIOS;
          if (!isIOS) {
            return AlertDialog(
              title: const Text(
                  "Order Completed!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text("Your order is going to be prepared in a short time.\n\n"
                  "You can check your status from your profile if you are curious.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/home");
                    },
                    child: const Text("Continue"))
              ],
            );
          }
          else {
            return CupertinoAlertDialog(
              title: const Text(
                "Order Completed!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text("Your order is going to be prepared in a short time.\n\n"
                  "You can check your status from your profile if you are curious.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/home");
                    },
                    child: const Text("Continue"))
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    print("CheckoutView build is called.");
    final user = Provider.of<User?>(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    double cartTotal = arguments["cart-total"];
    List<CartTile> _cartProducts = arguments["cart-products"];
    _allCheckoutTiles = _cartProducts.map((CartTile cartTile) {
      return CheckoutTile(product: cartTile.product, quantity: cartTile.quantity,);
    }).toList();


    final dummyItem = FootWearItem(
      productName: "aradas",
      brandName: "Nike",
      sellerName: "Melinda",
      price: 3.99,
      rating: 4.8,
      reviews: 1000,
    );

    setCurrentScreen(widget.analytics, "Checkout View", "checkoutView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Checkout",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Card Information",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Card Number",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: "MM/YY",
                              ),
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: "CVV",
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Address Information",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Enter a new address",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    AddressTile(),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CheckboxListTile(
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                            title: const Text('UTS Tower Building'),
                            subtitle: const Text('Boardway, Ultimo NSW'),
                            secondary: const Icon(
                                IconData(0xe3ab, fontFamily: 'MaterialIcons'),
                                size: 30),
                            selected: _value,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Wrap(
                            children: _allCheckoutTiles!,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text("$cartTotal₺", style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //FirebaseCrashlytics.instance.crash();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Order...')));

                            db.createOrder(user!.uid).then((value) {
                              showOrderCompleteDialog(context);
                            });
                          },
                          child: Text(
                            "Confirm",
                            style: kButtonDarkTextStyle,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
