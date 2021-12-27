import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';


class OrderUpdatesTile extends StatefulWidget {
  const OrderUpdatesTile({Key? key, required this.notificationDate,
    required this.orderNumber, required this.updateMessage}) : super(key: key);

  final String orderNumber;
  final String notificationDate;
  final String updateMessage;

  @override
  _OrderUpdatesTileState createState() => _OrderUpdatesTileState();
}

class _OrderUpdatesTileState extends State<OrderUpdatesTile> {
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
                      widget.notificationDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimen.sizedBox_5,),
              Row(
                children: [
                  const Text(
                    "Order Number: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.orderNumber),
                ],
              ),
              const SizedBox(height: Dimen.sizedBox_5,),
              Text(
                widget.updateMessage,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
            ],
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
