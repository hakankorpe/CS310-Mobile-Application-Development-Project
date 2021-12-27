import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/material.dart';

class CampaignTile extends StatefulWidget {
  const CampaignTile({Key? key, required this.notificationDate,
    required this.campaignMessage, required this.campaignLastDate}) : super(key: key);

  final String notificationDate;
  final String campaignMessage;
  final String campaignLastDate;

  @override
  _CampaignTileState createState() => _CampaignTileState();
}

class _CampaignTileState extends State<CampaignTile> {
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimen.sizedBox_5,),
              Text(
                  widget.campaignMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimen.sizedBox_5,),
              Row(
                children: [
                  const Text(
                    "Last Day of Campaign: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.campaignLastDate),
                ],
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
