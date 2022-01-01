import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookmarksTile extends StatelessWidget {
  final FootWearItem product;

  const BookmarksTile({
    required this.product,
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
                    Container(
                      child: product.image,
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.width / 5.5,
                    ),
                    const SizedBox(height: Dimen.sizedBox_5,),
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Brand Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                          "Price: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "${(product.price * (1 - product.discount!)).toStringAsFixed(2)}₺",
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
                          "Rating: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: product.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 5,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Seller:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimen.sizedBox_5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.sellerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
