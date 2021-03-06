import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/add_item_popup/add_item_popup.dart';

import 'data/data_model.dart';

class AppFrame extends StatelessWidget {
  final Widget body;
  AppFrame({@required this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<DataStorage>(
              builder: (_, data, __) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: data.currentUser == null
                        ? RaisedButton(
                            child: Text("Login"),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/auth');
                            })
                        : RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/myitems');
                            },
                            child: Text(data.currentUser.email)),
                  ))
        ],
      ),
      body: body,
      floatingActionButton: Consumer<DataStorage>(
          builder: (_, data, __) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                if (data.currentUser != null)
                  showDialog(context: context, builder: (c) => AddItemPopup());
                else
                  showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                            content: Text("Please login"),
                          ));
              })),
    );
  }
}
