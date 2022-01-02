import 'dart:io';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderTile extends StatefulWidget {
  OrderTile(
      {Key? key,
      required this.product,
      required this.orderDate,
      required this.orderID,
      required this.status,
      required this.quantity,
      required this.userID,
      this.reviewGiven})
      : super(key: key);

  final FootWearItem product;
  final String orderDate;
  final String orderID;
  final String status;
  final int quantity;
  final String userID;
  bool? reviewGiven;

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  String comment = "";
  double rating = 0.0;

  Future<void> showTextInputDialog(BuildContext context, String title,
      String hintText1, String hintText2) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final _formKey = GlobalKey<FormState>();
          bool isIOS = Platform.isIOS;
          if (!isIOS) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.number,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: hintText1,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a comment!';
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return 'Please enter a comment!';
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            print('saved $value');
                            comment = value;
                          }
                        },
                        onChanged: (value) {
                          comment = value;
                        },
                      ),
                      const SizedBox(height: Dimen.sizedBox_15),
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.number,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: hintText2,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a rating!';
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return 'Please enter a rating!';
                            }
                            if (0.0 > double.parse(value) || double.parse(value) > 5.0) {
                              return "Please enter a rating in the correct range!";
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            print('saved $value');
                            rating = double.parse(value);
                          }
                        },
                        onChanged: (value) {
                          rating = double.parse(value);
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Adding Review......')));

                          DBService db = DBService();

                          db
                              .addReview(
                            widget.userID,
                            widget.product.productToken!,
                            widget.product.sellerToken!,
                            comment,
                            rating,
                            widget.orderID,
                          )
                              .then((value) {
                            widget.reviewGiven = true;
                            setState(() {


                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added Review!')));
                            });

                          });
                        }
                      },
                      child: const Text("Give Review")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"))
                ],
              ),
            );
          } else {
            return Form(
              key: _formKey,
              child: CupertinoAlertDialog(
                title: Text(title),
                content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.number,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: hintText1,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: Dimen.sizedBox_5),
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.number,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: hintText2,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Adding Review......')));

                          DBService db = DBService();

                          db.addReview(
                            widget.userID,
                            widget.product.productToken!,
                            widget.product.sellerToken!,
                            comment,
                            rating,
                            widget.orderID,
                          );

                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added Review!')));
                        }
                      },
                      child: const Text("Give Review")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"))
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: Dimen.appBarElevation,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.orderDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimen.sizedBox_5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: widget.product.image,
                          width: MediaQuery.of(context).size.width / 5.5,
                          height: MediaQuery.of(context).size.width / 5.5,
                        ),
                        Text(
                          widget.product.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Order Number: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.orderID,
                                maxLines: 1,
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
                              "Order Status: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              widget.status,
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
                              widget.quantity.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimen.sizedBox_5,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Seller: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              widget.product.sellerName,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimen.sizedBox_5,
                        ),
                        if (widget.status == "Delivered")
                          ElevatedButton(
                            onPressed: () {
                              if (widget.reviewGiven!)
                                Navigator.popAndPushNamed(context, "/comments");
                              else
                                showTextInputDialog(context, "Give Review",
                                    "Enter comment", "Enter rating(0-5)");
                            },
                            child: Text(
                              widget.reviewGiven! ? "My Review" : "Give Review",
                              style: kButtonDarkTextStyle,
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
