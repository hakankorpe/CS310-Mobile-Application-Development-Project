import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_display.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/routes/edit_profile_view.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StorageService storage = StorageService();
  AuthService auth = AuthService();
  DBService db = DBService();
  dynamic _userInfo;
  List<FootWearItem> itemList = [];

  File? _image2;

  String _message = "";

  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'CS310_Test', parameters: <String, dynamic>{
      "string": "myString",
      "int": 12,
      "long": 123456789,
      "bool": true,
    });
    setMessage("setLogEvent succeeded.");
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: "Home View",
      screenClassOverride: "HomeView",
    );
    setMessage("setCurrentScreen succeeded.");
  }

  Future<void> _setUserId() async {
    await widget.analytics.setUserId("sayanarman");
    setMessage("setUserId succeeded.");
  }

  Future<void> initializeUserInfo(String userUID) async {
    final SharedPreferences prefs = await _prefs;
    Map<String, dynamic> userInfo = await db.getUserInfo(userUID);

    prefs.setString("user-info", jsonEncode(userInfo));

    //setState(() {
    _userInfo = jsonDecode(prefs.getString("user-info")!);
    //});

    print(_userInfo);

    storage.returnImage(_userInfo['userToken']);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    setState(() {
      _image2 = File('${appDocDir.path}/${_userInfo!['userToken']}.png');
    });
  }

  Future<void> getItemList([String? userID]) async {
    List<Map<String, dynamic>> allProducts = userID!.isNotEmpty
        ? await DBService().getProductsOnSale(userID)
        : await DBService()
            .getAllCollectionItems(DBService().productCollection);
    List<FootWearItem> newList =
        await Future.wait(allProducts.map((product) async {
      return await db.returnFootwearItem(product);
    }));

    setState(() {
      itemList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build is called.");
    final user = Provider.of<User?>(context);
    final arguments = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;

    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    if (itemList.isEmpty) {
      getItemList(arguments.isNotEmpty ? arguments["userID"] : "");
    }

    if (user != null) {
      if (_userInfo == null) {
        initializeUserInfo(user!.uid);

        if (_userInfo?["sign-in-type"] == "google-sign-in" &&
            _userInfo["username"] == "")
          return EditProfileView(analytics: analytics, observer: observer);
      }
    }

    setCurrentScreen(widget.analytics, "Home View", "homeView");

    final dummyItemList = itemList ?? [];

    String? username = arguments?["username"];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          username != null ? 'Market of $username' : 'Welcome To Footwear',
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
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimen.regularMargin),
        child: dummyItemList.isNotEmpty
            ? Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    FootWearDisplay(
                        itemList: dummyItemList, displayName: "Featured"),
                    FootWearDisplay(
                        itemList: dummyItemList
                            .where((element) => (element.discount ?? 0) > 0)
                            .toList(),
                        displayName: "Discounts"),
                    FootWearDisplay(
                        itemList: dummyItemList, displayName: "Just For You"),
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      "No products for this seller!\nVisit later.",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 0,
      ),
    );
  }
}
