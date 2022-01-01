import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class OrderUpdatesTile extends StatefulWidget {
  OrderUpdatesTile(
      {Key? key,
      required this.notificationDate,
      required this.orderNumber,
      required this.updateMessage,
      required this.notificationID})
      : super(key: key);

  final String orderNumber;
  final int notificationDate;
  final String updateMessage;
  final String notificationID;

  final stateMessages = const {
    "Order Received":
        "Your order is received it will be packed and delivered soon!",
    "Preparing Order": "Your order is packed it will be delivered soon!",
    "On Delivery": "Your order is on delivery right now!",
    "Delivered": "Your order is delivered, we hope you liked our products!",
  };

  @override
  _OrderUpdatesTileState createState() => _OrderUpdatesTileState();
}

class _OrderUpdatesTileState extends State<OrderUpdatesTile> {

  DBService db = DBService();

  var formatter = new DateFormat('yyyy-MM-dd').add_jm();

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
                  db.readNotification(widget.notificationID);
                },
                icon: Icons.mark_chat_read,
                label: "Read",
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
              ),
            ],
          ),
          child: Card(
            elevation: Dimen.appBarElevation,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formatter.format(DateTime.fromMillisecondsSinceEpoch(widget.notificationDate)),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
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
                      "Order Number: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.orderNumber),
                  ],
                ),
                const SizedBox(
                  height: Dimen.sizedBox_5,
                ),
                Text(
                  widget.stateMessages[widget.updateMessage] ?? "",
                  maxLines: 5,
                  textAlign: TextAlign.center,
                ),
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
