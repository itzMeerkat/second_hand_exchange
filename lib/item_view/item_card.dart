import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_exchange/data/item_record.dart';
import 'package:second_hand_exchange/item_view/card_popup.dart';

class ItemCard extends StatelessWidget {
  final ItemRecord data;

  const ItemCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CardPopup(
              data: data,
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              if (data.image != null) Image.memory(base64Decode(data.image)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(data.description)),
              Text(
                "Original Price: \$${data.originalPrice.toString()}",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text("Current Price: \$${data.currentPrice.toString()}")
            ],
          ),
        ));
  }
}
