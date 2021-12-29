import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CommentApproveTile extends StatelessWidget {
  final FootWearItem product;
  final String username;
  final String comment;
  final VoidCallback approveComment;
  final VoidCallback denyComment;
  final String reviewID;

  const CommentApproveTile({
    required this.product,
    required this.username,
    required this.comment,
    required this.approveComment,
    required this.denyComment,
    required this.reviewID,
  });

  @override
  Widget build(BuildContext context) {

    DBService db = DBService();

    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            extentRatio: 1 / 4,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  db.approveReview(reviewID).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Approved Review!')));
                  });
                },
                icon: Icons.delete,
                label: "Approve",
                backgroundColor: Colors.lightGreenAccent,
                foregroundColor: Colors.white,
              ),
              SlidableAction(
                onPressed: (context) {
                  db.denyReview(reviewID).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Denied Review!')));
                  });
                },
                icon: Icons.delete,
                label: "Deny",
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ],
          ),
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
                            Container(
                              child: product.image,
                              width: MediaQuery.of(context).size.width / 5.5,
                              height: MediaQuery.of(context).size.width / 5.5,
                            ),
                            Text(
                              product.productName,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_pin_rounded,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    username,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Dimen.sizedBox_5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                comment,
                                style: const TextStyle(
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
                              onPressed: () {
                                db.approveReview(reviewID).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Approved Review!')));
                                });
                              },
                              icon: const Icon(Icons.check_box_rounded),
                              iconSize: 30,
                            ),
                            IconButton(
                              onPressed: () {
                                db.denyReview(reviewID).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Denied Review!')));
                                });
                              },
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

              ],
            ),
          ),
        ),
        const Divider(
          thickness: Dimen.divider_2,
          height: 0,
        ),
      ],
    );
  }
}
