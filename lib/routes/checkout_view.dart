import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
  final _formKey2 = GlobalKey<FormState>();
  bool _value = false;
  String mainAddress = "";
  String detailedAddress = "";
  bool firstTime = true;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;

  StreamSubscription<DocumentSnapshot>? streamSub;

  double? cartTotal;
  List<CheckoutTile>? _allCheckoutTiles;
  List<AddressTile>? allAddresses;

  Future<void> showOrderCompleteDialog(
    BuildContext context,
  ) async {
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
              content: const Text(
                "Your order is going to be prepared in a short time.\n\n"
                "You can check your status from your profile if you are curious.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                    },
                    child: const Text("Continue"))
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: const Text(
                "Order Completed!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text(
                "Your order is going to be prepared in a short time.\n\n"
                "You can check your status from your profile if you are curious.",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                    },
                    child: const Text("Continue"))
              ],
            );
          }
        }).then((value) {
      //Navigator.popAndPushNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("CheckoutView build is called.");
    final user = Provider.of<User?>(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    double cartTotal = arguments["cart-total"];
    List<CartTile> _cartProducts = arguments["cart-products"];

    if (firstTime) {
      firstTime = false;
      streamSub = db.addressCollection
          .doc(user!.uid)
          .snapshots()
          .listen((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> deneme =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          allAddresses = deneme.entries
              .map((e) =>
                  AddressTile(mainAddress: e.key, detailedAddress: e.value))
              .toList();
        });
      });
    }

    _allCheckoutTiles = _cartProducts.map((CartTile cartTile) {
      return CheckoutTile(
        product: cartTile.product,
        quantity: cartTile.quantity,
      );
    }).toList();

    Future<void> showTextInputDialog(BuildContext context, String title,
        String hintText1, String hintText2) async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            final _formKey = GlobalKey<FormState>();
            bool isIOS = Platform.isIOS;
            if (!isIOS) {
              return Form(
                key: _formKey,
                child: AlertDialog(
                  title: Text(title),
                  content: SingleChildScrollView(
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            maxLines: 2,
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                print('saved $value');
                                mainAddress = value;
                              }
                            },
                            onChanged: (value) {
                              mainAddress = value;
                            },
                            decoration: InputDecoration(
                              hintText: hintText1,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: Dimen.sizedBox_15),
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            maxLines: 2,
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                print('saved $value');
                                detailedAddress = value;
                              }
                            },
                            onChanged: (value) {
                              detailedAddress = value;
                            },
                            decoration: InputDecoration(
                              hintText: hintText2,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          print(mainAddress);

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            print(detailedAddress);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Adding Address......')));

                            DBService db = DBService();

                            db.addAddress(
                                user!.uid, mainAddress, detailedAddress);

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Added Address!')));
                          }
                        },
                        child: const Text("Enter an Address")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"))
                  ],
                ),
              );
            } else {
              return Form(
                key: _formKey,
                child: CupertinoAlertDialog(
                  title: Text(title),
                  content: SingleChildScrollView(
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: hintText1,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: Dimen.sizedBox_5),
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: hintText2,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Adding The Address......')));

                            DBService db = DBService();

                            db.addAddress(
                                user!.uid, mainAddress, detailedAddress);

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Address Review!')));
                          }
                        },
                        child: const Text("Enter An Address")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"))
                  ],
                ),
              );
            }
          });
    }

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
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      cardBgColor: Colors.red,
                      glassmorphismConfig: useGlassMorphism
                          ? Glassmorphism.defaultConfig()
                          : null,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      height: 175,
                      textStyle: const TextStyle(color: Colors.yellowAccent),
                      width: MediaQuery.of(context).size.width,
                      isChipVisible: true,
                      isSwipeGestureEnabled: true,
                      animationDuration: const Duration(milliseconds: 1000),
                      onCreditCardWidgetChange: (CreditCardBrand) {},
                    ),
                    CreditCardForm(
                      formKey: _formKey2,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      onCreditCardModelChange:
                          (CreditCardModel creditCardModel) {
                        setState(() {
                          cardNumber = creditCardModel.cardNumber;
                          expiryDate = creditCardModel.expiryDate;
                          cardHolderName = creditCardModel.cardHolderName;
                          cvvCode = creditCardModel.cvvCode;
                          isCvvFocused = creditCardModel.isCvvFocused;
                        });
                      },
                      themeColor: Colors.red,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardNumberDecoration: const InputDecoration(
                        labelText: "Number",
                        hintText: "XXXX XXXX XXXX XXXX",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      expiryDateDecoration: const InputDecoration(
                        labelText: "Expiration Date",
                        hintText: "XX/XX",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        labelText: "CVV",
                        hintText: "XXX",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      cardHolderDecoration: const InputDecoration(
                        labelText: "Name Surname",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),

                    /*const Text(
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
                    ),*/
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
                        onPressed: () {
                          showTextInputDialog(context, "Enter a new address",
                              "Main Address", "Detailed Address");
                        },
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
                Wrap(
                  children: allAddresses ?? [],
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
                        Text(
                          "${cartTotal.toStringAsFixed(2)}₺",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey2.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Order...')));
                              List<String> voilatingProducts = await db.checkCartStock(user!.uid);
                              if (voilatingProducts.isEmpty) {
                                await db.createOrder(user!.uid);
                                await showOrderCompleteDialog(context);
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Some stocks of product are updated!\n'
                                            'Please update the quantity of the products given below:\n'
                                            '${voilatingProducts.join(",")}')));
                              }
                            }
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
