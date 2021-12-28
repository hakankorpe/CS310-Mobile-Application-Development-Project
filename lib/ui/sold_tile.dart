import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class SoldTile extends StatelessWidget {
  final FootWearItem product;
  final double sellingPrice;
  final int soldCount;
  final double profit;
  final double netGain;

  const SoldTile({
    required this.product,
    required this.sellingPrice,
    required this.soldCount,
    required this.profit,
    required this.netGain,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimen.appBarElevation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      child: product.image,
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.width / 5.5,
                    ),
                    Text(
                      product.productName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Initial Price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${product.initialPrice!.toStringAsFixed(2)}₺",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Selling Price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${sellingPrice.toStringAsFixed(2)}₺",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Quantity: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${soldCount}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //const SizedBox(width: Dimen.sizedBox_15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Profit: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${profit.toStringAsFixed(2)}₺",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Net Gain: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${netGain.toStringAsFixed(2)}₺",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: Dimen.divider_2,
          ),
        ],
      ),
    );
  }
}
