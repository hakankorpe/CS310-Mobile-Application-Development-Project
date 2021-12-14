import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final FootWearItem product;
  final VoidCallback remove;
  final VoidCallback applyDiscount;
  final VoidCallback stockUpdate;
  final VoidCallback priceUpdate;

  const ProductTile({
    required this.product,
    required this.remove,
    required this.applyDiscount,
    required this.stockUpdate,
    required this.priceUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: Dimen.appBarElevation,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Image.network(
                      product.imageUrl,
                    width: MediaQuery.of(context).size.width /3.5,
                    height: MediaQuery.of(context).size.width /3.5,
                  ),
                  Text(product.brandName),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Price: "),
                      Text(
                        product.price.toString() + "₺",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                          "${product.price * (1 - product.discount!)}"
                      ),
                      const SizedBox(width: Dimen.sizedBox_5,),
                      IconButton(
                          onPressed: priceUpdate,
                          icon: const Icon(Icons.edit_sharp),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimen.sizedBox_5,),
                  Row(
                    children: [
                      const Text("Stock: "),
                      Text("x ${product.stockCount}",),
                      IconButton(
                        onPressed: stockUpdate,
                        icon: const Icon(Icons.edit_sharp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
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
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimen.sizedBox_5,),
                  OutlinedButton(
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: applyDiscount,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
