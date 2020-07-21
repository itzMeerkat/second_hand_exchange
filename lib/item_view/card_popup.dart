import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_exchange/data/item_record.dart';

class CardPopup extends StatelessWidget {
  final ItemRecord data;

  const CardPopup({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
            child: Column(
      children: [
        if (data.image != null) Image.memory(base64Decode(data.image)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(data.description)),
        Text("Current Price: \$${data.currentPrice.toString()}"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("Contact: ${data.contact}"),
        )
      ],
    )));
  }
}
