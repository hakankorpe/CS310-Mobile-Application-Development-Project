import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import "package:cs310_footwear_project/utils/dimension.dart";
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

class CartTile extends StatefulWidget{

  final FootWearItem product;
  int? quantity;

  CartTile({
    required this.product,
    this.quantity,
});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: Dimen.appBarElevation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(flex: 3, child: Text("Shoe B",textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold))),
              const Expanded(flex: 2, child: Image(
                  image: NetworkImage(
                      "https://www.pinclipart.com/picdir/big/338-3385006_download-shoe-png-hd-clipart.png")
              ),
              ),
              const Expanded(flex: 2, child: Text("100" + "₺",textAlign: TextAlign.center)),
              Expanded(flex: 2, child: Container(color: Colors.black12,
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.quantity.toString(), textAlign: TextAlign.center),
                      IconButton(
                        constraints: const BoxConstraints(minHeight: 30),
                        onPressed: (){
                          showMaterialNumberPicker(
                            context: context,
                            title: 'Quantity', //TODO: daha iyi ifade edilebilir
                            maxNumber: 91, // TODO: maximum item number
                            minNumber: 1,
                            selectedNumber: widget.quantity,
                            onChanged: (value) => setState(() => widget.quantity = value),
                          );
                        },
                        icon: const Icon(Icons.arrow_downward_rounded),
                        iconSize: 17,
                      ),
                    ]
                ),
              ),
              ),
              const Expanded(flex: 2, child: Text("370" //TODO: datadan birim fiyati alinacak
                  +
                  "₺",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold))),
            ],
          ),
          const Divider(thickness: Dimen.divider_1_5,)
        ],
      ),
    );
  }
}