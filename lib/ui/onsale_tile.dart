import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class OnSaleTile extends StatelessWidget {
  final FootWearItem product;
  final VoidCallback remove;
  final VoidCallback applyDiscount;
  final VoidCallback stockUpdate;
  final VoidCallback priceUpdate;

  const OnSaleTile({
    required this.product,
    required this.remove,
    required this.applyDiscount,
    required this.stockUpdate,
    required this.priceUpdate,
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
              Column(
                children: [
                  Container(
                    child: product.image,
                    width: MediaQuery.of(context).size.width / 5.5,
                    height: MediaQuery.of(context).size.width / 5.5,
                  ),
                  Text(
                    product.brandName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            product.price.toString() + "₺",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("${product.price * (1 - product.discount!)}"),
                        ],
                      ),
                      IconButton(
                        onPressed: priceUpdate,
                        icon: const Icon(
                          Icons.edit_sharp,
                        ),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  //const SizedBox(height: Dimen.sizedBox_5,),
                  Row(
                    children: [
                      const Text(
                        "Stock: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "x${product.stockCount}",
                      ),
                      IconButton(
                        onPressed: stockUpdate,
                        icon: const Icon(
                          Icons.edit_sharp,
                        ),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
              //const SizedBox(width: Dimen.sizedBox_15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton(
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: remove,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 0,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: applyDiscount,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.amberAccent,
                        width: 0,
                      ),
                    ),
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
