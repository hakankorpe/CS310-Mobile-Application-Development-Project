import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


class AddProductView extends StatefulWidget {
  const AddProductView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("AddProductView build is called.");

    setCurrentScreen(widget.analytics, "Add Product View", "addProductView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
            "Add Product",
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
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Product Image"),
                          Image.network(
                              "https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?b=1&k=20&m=1249496770&s=170667a&w=0&h=_SUv4odBqZIzcXvdK9rqhPBIenbyBspPFiQOSDRi-RI=",
                              height: 180,
                              width: 180,
                          ),
                          TextFormField(

                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(

                          ),
                          TextFormField(

                          ),
                          TextFormField(

                          ),
                          TextFormField(

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_30,),
                const Divider(thickness: Dimen.divider_1_5,),
                const Text("Product Details"),
                const Divider(thickness: Dimen.divider_1_5,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: TextFormField(

                        ),
                    ),
                  ],
                ),
                OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                        "Confirm"
                    ),
                ),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
