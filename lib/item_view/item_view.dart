import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_exchange/data/item_record.dart';
import 'package:second_hand_exchange/item_view/item_card.dart';

class ItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ItemViewState();
  }
}

class ItemViewState extends State<ItemView> {
  List<ItemRecord> cards = List();

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('items')
        .where('status', isEqualTo: 'active')
        .limit(20)
        .snapshots()
        .listen((snapshot) {
      print("Get and build");
      cards = snapshot.documents.map((e) {
        return ItemRecord(
            image: e.data['image'],
            description: e.data['description'],
            originalPrice: e.data['originalPrice'],
            currentPrice: e.data['currentPrice'],
            uid: e.data['uid'],
            contact: e.data['contact']);
      }).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (c, i) => ItemCard(data: cards[i]),
    );
  }
}
