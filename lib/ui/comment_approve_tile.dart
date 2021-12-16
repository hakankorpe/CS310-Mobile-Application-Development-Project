import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class  CommentApproveTile extends StatelessWidget {

  final FootWearItem product;
  final VoidCallback remove;
  final VoidCallback applyDiscount;
  final VoidCallback stockUpdate;
  final VoidCallback priceUpdate;

  const CommentApproveTile({
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      product.imageUrl,
                      width: MediaQuery.of(context).size.width /5.5,
                      height: MediaQuery.of(context).size.width /5.5,
                    ),
                    Text(
                      product.brandName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              //const SizedBox(width: Dimen.sizedBox_15,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person_pin_rounded,),
                        Text(
                          "test_sayanarman",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimen.sizedBox_5,),
                    const Text(
                        "kdhsfbksdfsbdguhakdfjbkjdfgvufgdau",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      maxLines: 15,
                      ),
                  ],
                ),
              ),
              //const SizedBox(width: Dimen.sizedBox_15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.check_box_rounded),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.indeterminate_check_box_rounded),
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(thickness: Dimen.divider_2,),
        ],
      ),
    );
  }
}