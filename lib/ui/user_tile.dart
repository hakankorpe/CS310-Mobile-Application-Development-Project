import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked_services/stacked_services.dart';

class UserTile extends StatelessWidget {
  final double rating;
  Image? img;
  final String userID;
  final String username;
  final String displayName;

  UserTile({
    required this.rating,
    required this.userID,
    required this.username,
    required this.displayName,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () => Navigator.of(context).pushNamed("/home",
          arguments: {"userID": userID, "username": username}),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Container(
                      child: (img ??
                          Image.network(
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.black,
                                ),
                              );
                            },
                          )),
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Dimen.sizedBox_5,
              ),
              Text(
                username,
                style: const TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Row(
              children: [
                const Text(
                  "Rating:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //TODO: find a BETTER star rating bar
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
            )
          ]),
        ],
      ),
    );
  }
}
