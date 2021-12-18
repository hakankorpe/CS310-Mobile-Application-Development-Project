import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class CommentApproveTile extends StatelessWidget {
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
    return Container(
      height: MediaQuery.of(context).size.height / 6.5,
      child: Card(
        elevation: Dimen.appBarElevation,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          product.imageUrl,
                          width: MediaQuery.of(context).size.width / 5.5,
                          height: MediaQuery.of(context).size.width / 5.5,
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
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.person_pin_rounded,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "test_sayanarmasdadadadsddsadsddsaadn",
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimen.sizedBox_5,
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "abcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcddefghdefghabcdefghabcdefghabcdefghabcdefgh",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            softWrap: false,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //const SizedBox(width: Dimen.sizedBox_15,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_box_rounded),
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.indeterminate_check_box_rounded),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: Dimen.divider_2,
            ),
          ],
        ),
      ),
    );
  }
}
