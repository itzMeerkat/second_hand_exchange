import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_web/file_picker_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/data/data_model.dart';
import 'package:second_hand_exchange/data/item_record.dart';

class AddItemPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddItemPopupState();
  }
}

class AddItemPopupState extends State<AddItemPopup> {
  Uint8List dispImage;
  File imageFileRef;
  TextEditingController descriptionCon = TextEditingController(),
      opCon = TextEditingController(),
      cpCon = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
            child: Form(
                child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dispImage != null) Image.memory(dispImage),
        RaisedButton(onPressed: () async {
          File file = await FilePicker.getFile();
          imageFileRef = file;
          FileReader fr = FileReader();
          fr.onLoadEnd.listen((event) {
            print("LoadEnd");
            img.Image _i = img.decodeImage(fr.result);
            //print("DecodeImage");
            _i = img.copyResize(_i, width: 500);
            //print("ResizeImage");
            Uint8List smallImg = img.encodePng(_i);
            //print("EncodeImage");
            print(smallImg.lengthInBytes);
            dispImage = smallImg;
            setState(() {});
          });
          fr.onError.listen((event) {
            print("Error");
          });
          fr.readAsArrayBuffer(file.slice());
        }),
        TextFormField(
          decoration: InputDecoration(labelText: "Description"),
          controller: descriptionCon,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Original Price"),
          controller: opCon,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Current Price"),
          controller: cpCon,
        ),
        RaisedButton(onPressed: () {
          FirebaseUser user =
              Provider.of<DataStorage>(context, listen: false).currentUser;
          String base64Img;
          if (dispImage != null) base64Img = base64Encode(dispImage);

          print(descriptionCon.text);
          Firestore.instance.collection('items').add(ItemRecord(
                  uid: user.uid,
                  contact: Provider.of<DataStorage>(context, listen: false)
                      .userProfile
                      .contact,
                  description: descriptionCon.text,
                  originalPrice: int.parse(opCon.text),
                  currentPrice: int.parse(cpCon.text),
                  image: base64Img)
              .toJSON());
          Navigator.of(context).pop();
        }),
      ],
    ))));
  }
}
