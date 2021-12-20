import 'dart:ui';

import 'package:cs310_footwear_project/components/footwear_item.dart';
import "package:cs310_footwear_project/utils/dimension.dart";
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

class AddressTile extends StatefulWidget {
  bool _value = false;

  @override
  _AddressTileState createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CheckboxListTile(value: widget._value, onChanged: (value) {
            setState(() {
              widget._value = value!;
            });
          },
            title: const Text('Central Station Grand Course'),
            subtitle: const Text('Address detailed'),
            secondary: const Icon(IconData(0xe3ab, fontFamily: 'MaterialIcons'), size: 30),
            selected: widget._value,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
            ),
          ),
        ],
      ),
    );
  }
}

