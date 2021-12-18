import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentsTile extends StatelessWidget {
  final FootWearItem product;

  const CommentsTile({
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
              Column(
                children: [
                  Image.network(
                    product.imageUrl,
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                  ),
                ],
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Expanded(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Product Name: ",
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
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimen.sizedBox_5,
                    ),
                    Row(children: [
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
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: Dimen.sizedBox_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Seller: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.sellerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
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
                          "Your Rating: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: product.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
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
                    const SizedBox(
                      height: Dimen.sizedBox_5,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Review Status: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Text("02/11/2021")],
              ),
            ],
          ),
          const SizedBox(
            height: Dimen.sizedBox_5,
          ),
          Row(
            children: const [
              Text(
                "Your Comment: ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Text(
                  "jsdflsfkjbflsjkbsnflkjbsfljdsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasgljsblgjsbblfjbslfjbslbjfslfdbslbjlsdfjbsflbjhvabflkjfbvskjbfskjfbsk",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  //textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
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
