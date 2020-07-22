import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/auth_view/auth_view.dart';
import 'package:second_hand_exchange/data/data_model.dart';
import 'package:second_hand_exchange/item_view/item_view.dart';
import 'package:second_hand_exchange/user_view/own_items.dart';

import 'app_frame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DataStorage(),
        child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/auth': (context) => AuthView(),
              '/myitems': (context) => OwnItems()
            },
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AppFrame(
              body: ItemView(),
            )));
  }
}
