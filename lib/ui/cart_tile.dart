import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import "package:cs310_footwear_project/utils/dimension.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartTile extends StatefulWidget {
  final FootWearItem product;
  int? quantity;
  String? userID;

  CartTile({
    required this.product,
    this.quantity,
    this.userID,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
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
                  DBService().cartCollection.doc(widget.userID).update(
                      {widget.product.productToken!: FieldValue.delete()});
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(widget.product.productName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: widget.product.image,
                        width: MediaQuery.of(context).size.width / 5.5,
                        height: MediaQuery.of(context).size.width / 5.5,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${(widget.product.price * (1 - widget.product.discount!)).toStringAsFixed(2)}₺",
                            textAlign: TextAlign.center)),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.black12,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.quantity.toString(),
                                  textAlign: TextAlign.center),
                              IconButton(
                                constraints:
                                    const BoxConstraints(minHeight: 30),
                                onPressed: () {
                                  showMaterialNumberPicker(
                                    context: context,
                                    title:
                                        'Update Quantity',
                                    maxNumber: widget.product.stockCount!,
                                    minNumber: 1,
                                    selectedNumber: widget.quantity,
                                    onChanged: (value) => setState(() {
                                      DBService().updateProductQuantityAtCart(
                                          widget.userID!,
                                          widget.product.productToken!,
                                          value);
                                      widget.quantity = value;
                                    }),
                                  );
                                },
                                icon: const Icon(Icons.arrow_downward_rounded),
                                iconSize: 17,
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${(widget.product.price * (1 - widget.product.discount!) * widget.quantity!).toStringAsFixed(2)}₺",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                //const SizedBox(height: 5,),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: Dimen.divider_1_5,
          height: 0,
        ),
      ],
    );
  }
}
