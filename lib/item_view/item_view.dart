import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/data/data_model.dart';
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
        .limit(20)
        .snapshots()
        .listen((snapshot) {
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
    return StaggeredGridView.count(
      crossAxisCount: 2,
      children: cards.map((e) => ItemCard(data: e)).toList(),
      staggeredTiles: cards.map((e) => StaggeredTile.fit(1)).toList(),
    );
  }
}
