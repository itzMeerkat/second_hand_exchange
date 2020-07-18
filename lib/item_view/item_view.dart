import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/auth_view/auth_view.dart';
import 'package:second_hand_exchange/data/data_model.dart';

class ItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ItemViewState();
  }
}

const List<String> fakeData = ['a', 'b', 'c', 'd', 'e'];

class ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<DataStorage>(
            builder: (context, data, child) => data.currentUser == null
                ? RaisedButton(
                    child: Text("Login"),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/auth');
                    })
                : Text(data.currentUser.email),
          )
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        children: fakeData.map((e) => Card(child: Text(e))).toList(),
        staggeredTiles: fakeData.map((e) => StaggeredTile.fit(1)).toList(),
      ),
    );
  }
}
