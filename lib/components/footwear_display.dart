import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/cupertino.dart';

class FootWearDisplay extends StatefulWidget {
  List<FootWearItem> itemList;
  final String displayName;
  FootWearDisplay({
    Key? key,
    required this.itemList,
    required this.displayName,
  }) : super(key: key);

  @override
  State<FootWearDisplay> createState() => _FootWearDisplayState();
}

class _FootWearDisplayState extends State<FootWearDisplay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: Dimen.sizedBox_5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(spacing: 15.0, children: widget.itemList),
          ),
        ],
      ),
    );
  }
}
