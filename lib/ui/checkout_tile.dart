import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import "package:cs310_footwear_project/utils/dimension.dart";
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

class CheckoutTile extends StatefulWidget {
  final FootWearItem product;
  int? quantity;

  CheckoutTile({
    required this.product,
    this.quantity,
  });

  @override
  _CheckoutTileState createState() => _CheckoutTileState();
}

class _CheckoutTileState extends State<CheckoutTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: Dimen.appBarElevation,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: widget.product.image,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 0.0, 5.0),
                        child: Text(widget.product.productName,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            IconData(0xebbf, fontFamily: 'MaterialIcons'),
                            color: Colors.black,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                          label: Text(
                            widget.product.sellerName,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      "${widget.product.price * (1 - widget.product.discount!) * widget.quantity!}₺",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: Dimen.sizedBox_5)
          ],
        ));
  }
}
