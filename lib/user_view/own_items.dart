import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/data/data_model.dart';
import 'package:second_hand_exchange/data/item_record.dart';

class OwnItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OwnItemsState();
  }
}

class OwnItemsState extends State<OwnItems> {
  List<ItemRecord> items;
  List<String> docIds;
  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    Firestore.instance
        .collection('items')
        .where('uid',
            isEqualTo: Provider.of<DataStorage>(context, listen: false)
                .currentUser
                .uid)
        .snapshots()
        .listen((event) {
      items = event.documents
          .map((e) => ItemRecord(
              image: e.data['image'],
              uid: e.data['uid'],
              description: e.data['description'],
              currentPrice: e.data['currentPrice'],
              originalPrice: e.data['originalPrice'],
              contact: e.data['contact'],
              status: e.data['status']))
          .toList();
      docIds = event.documents.map((e) => e.documentID).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemExtent: 150,
        itemCount: items == null ? 0 : items.length,
        itemBuilder: (context, i) {
          return Card(
            child: Row(children: [
              if (items[i].image != null)
                Image.memory(base64Decode(items[i].image)),
              Text(items[i].description),
              Spacer(),
              Text("Status: ${items[i].status}"),
              Column(
                children: [
                  RaisedButton.icon(
                      onPressed: () async {
                        await Firestore.instance
                            .collection('items')
                            .document(docIds[i])
                            .setData({'status': 'sold'}, merge: true);
                      },
                      icon: Icon(Icons.check),
                      label: Text("Sold")),
                  RaisedButton.icon(
                      onPressed: () async {
                        await Firestore.instance
                            .collection('items')
                            .document(docIds[i])
                            .setData({'status': 'disabled'}, merge: true);
                      },
                      icon: Icon(Icons.delete),
                      label: Text("Disable")),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
