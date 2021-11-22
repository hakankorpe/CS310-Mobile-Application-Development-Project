import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class CartView extends StatefulWidget {
  const CartView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    print("CartView build is called.");
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
       body: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             const SizedBox(height: 20,),
             const Divider(thickness: 1.5,),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: const [
                 Expanded(flex: 3, child: Text("Product")),
                 Expanded(flex: 2, child: Text("Price")),
                 Expanded(flex: 2, child: Text("Quantity")),
                 Expanded(flex: 2, child: Text("Subtotal")),
               ],
             ),
             const Divider(thickness: 1.5,),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: const [
                 Expanded(flex: 3, child: Text("Product")),
                 Expanded(flex: 2, child: Text("Price")),
                 Expanded(flex: 2, child: Text("Quantity")),
                 Expanded(flex: 2, child: Text("Subtotal")),
               ],
             ),
             const Divider(thickness: 1.5,),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: const [
                 Expanded(flex: 3, child: Text("Product")),
                 Expanded(flex: 2, child: Text("Price")),
                 Expanded(flex: 2, child: Text("Quantity")),
                 Expanded(flex: 2, child: Text("Subtotal")),
               ],
             ),
             const Divider(thickness: 1.5,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: const [
                 Text("Total"),
                 Text("570₺"),
               ],
             ),
             const SizedBox(height: 20,),
             OutlinedButton(
                 onPressed: () {
                   Navigator.pushNamed(context, "/checkout");
                 },
                 child: const Text("Continue"),
             ),
           ],
         ),
       ),
      bottomNavigationBar: NavigationBar(index: 0,),
    );
  }
}
