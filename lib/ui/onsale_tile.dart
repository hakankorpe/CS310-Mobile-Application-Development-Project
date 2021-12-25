import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Directory, File, Platform;

import 'package:flutter_slidable/flutter_slidable.dart';

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

  Future<void> showTextInputDialog(BuildContext context, String title, String hintText,) async {
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
                content: TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Updating......')));

                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Updated!')));
                        }
                      },
                      child: const Text("Update")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"))
                ],
              ),
            );
          }
          else {
            return Form(
              key: _formKey,
              child: CupertinoAlertDialog(
                title: Text(title),
                content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.number,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: hintText,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Update")),
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
        Slidable(
          endActionPane: ActionPane(
            extentRatio: 1 / 4,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  //DBService().cartCollection.doc(widget.userID).update(
                   //   {widget.product.productToken!: FieldValue.delete()});
                  DBService().deleteProductOnSale(product.productToken!);
                },
                icon: Icons.delete,
                label: "Delete",
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ],
          ),
          child: Card(
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
                          style: const TextStyle(
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
                              onPressed: () {
                                showTextInputDialog(context, "Update Price", "Enter new price (₺)",);
                              },
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
                              onPressed: () {
                                showTextInputDialog(context, "Update Stock Quantity", "Enter new quantity",);
                              },
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
                            "Discount",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            showTextInputDialog(context, "Apply Discount", "Enter new discount rate (0.0 - 1.0)",);
                          },
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
