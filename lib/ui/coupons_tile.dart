import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class CouponsTile extends StatefulWidget {
  const CouponsTile({Key? key, required this.couponCode, required this.couponExpirationDate}) : super(key: key);

  final String couponCode;
  final String couponExpirationDate;

  @override
  _CouponsTileState createState() => _CouponsTileState();
}

class _CouponsTileState extends State<CouponsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: Dimen.appBarElevation,
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Coupon Code: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.couponCode),
                ],
              ),
              const SizedBox(height: Dimen.sizedBox_5,),
              Row(
                children: [
                  const Text(
                    "Expiration Date: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.couponExpirationDate),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: Dimen.divider_1_5,
          height: 0,
        ),
      ],
    );
  }
}
