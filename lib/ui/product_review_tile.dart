import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ProductReviewTile extends StatelessWidget {

  final String username;
  final double rating;
  final String comment;
  final String reviewDate;

  const ProductReviewTile({
    required this.username,
    required this.rating,
    required this.comment,
    required this.reviewDate,
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimen.appBarElevation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                reviewDate,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimen.sizedBox_5,
          ),
          Row(
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: Dimen.sizedBox_20,),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: rating,
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
          const SizedBox(
            height: Dimen.sizedBox_5,
          ),
          Row(
            children: [
              Text(
                comment
              ),
            ],
          ),
          //const Divider(thickness: Dimen.divider_1_5,),
        ],
      ),
    );
  }
}
