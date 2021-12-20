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
    return Card(elevation: Dimen.appBarElevation,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(flex: 2, child: Image(
                image: NetworkImage(
                    "https://www.pinclipart.com/picdir/big/338-3385006_download-shoe-png-hd-clipart.png")
            ),
            ),
            Expanded(flex: 4, child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0,12.0,0.0,5.0),
                  child: Text("Shoe B",textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold)),
                ),
                OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      IconData(0xebbf, fontFamily: 'MaterialIcons'),
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Esenler",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                ),
              ],
            ),
            ),
            const Expanded(flex: 2, child:Text("100" + "₺",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold)
            ),
            ),
          ],
        ),
        const SizedBox(height: Dimen.sizedBox_5)
      ],
    ));
  }
}
