import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

class SoldTile extends StatefulWidget {
  final FootWearItem product;
  final String soldID;
  final double sellingPrice;
  final int soldCount;
  final double profit;
  final double netGain;
  String? status;
  final String buyer;

  SoldTile({
    required this.product,
    required this.sellingPrice,
    required this.soldCount,
    required this.profit,
    required this.netGain,
    this.status,
    required this.buyer,
    required this.soldID,
  });

  @override
  State<SoldTile> createState() => _SoldTileState();
}

class _SoldTileState extends State<SoldTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimen.appBarElevation,
      child: Column(
        children: [
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
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimen.sizedBox_15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Buyer: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.buyer,
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
                        "Initial Price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${widget.product.initialPrice!.toStringAsFixed(2)}₺",
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
                        "Selling Price: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${widget.sellingPrice.toStringAsFixed(2)}₺",
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
                        "Quantity: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${widget.soldCount}",
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
                        "Profit: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${widget.profit.toStringAsFixed(2)}₺",
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
                        "Net Gain: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${widget.netGain.toStringAsFixed(2)}₺",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //const SizedBox(width: Dimen.sizedBox_15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_15,
                  ),
                  ActionChip(
                    backgroundColor: Colors.black,
                    avatar: const Icon(
                      Icons.change_circle,
                      color: Colors.white,
                    ),
                    label: Text(
                        widget.status!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      showMaterialScrollPicker(
                          context: context,
                          title: "Choose a status update",
                          items: [
                            "Order Received",
                            "Preparing Order",
                            "On Delivery",
                            "Delivered"
                          ],
                          selectedItem: 1,
                          onChanged: (value) {
                            widget.status = value.toString();
                            //sorter = sorterHelper(value.toString(),);
                          }).then((value) {
                        DBService()
                            .updateOrderStatus(widget.soldID, widget.status!)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Order Status Updated!')));
                        });
                        setState(() {
                          //sortSelected = selected;
                        });
                      });
                    },
                  ),
                ],
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
