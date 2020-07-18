import 'dart:html' as html;

import 'package:flutter/material.dart';

class AddItemPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddItemPopupState();
  }
}

class AddItemPopupState extends State<AddItemPopup> {
  html.File image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Image.file(image),
        RaisedButton(onPressed: null),
        TextFormField(),
        TextFormField(),
        TextFormField(),
        RaisedButton(onPressed: null),
      ],
    )));
  }
}
