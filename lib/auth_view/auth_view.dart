import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_exchange/data/data_model.dart';
import 'package:second_hand_exchange/utils.dart' as utils;

class AuthView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthViewState();
  }
}

class AuthViewState extends State<AuthView> {
  bool loginOrSignUp = false; // false: login, true: sign up

  TextEditingController tc1 = TextEditingController(),
      tc2 = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
        message: "Wait a sec...", progressWidget: CircularProgressIndicator());
    return Scaffold(
        appBar: AppBar(
          title: loginOrSignUp ? Text("Sign up") : Text("Login"),
          actions: [
            FlatButton(
                onPressed: () {
                  loginOrSignUp = !loginOrSignUp;
                  tc1.clear();
                  tc2.clear();
                  setState(() {});
                },
                child: loginOrSignUp ? Text("Login") : Text("Sign up"))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(50),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: tc1,
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      controller: tc2,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) => value.length >= 6
                          ? null
                          : "Password must be 6 characters or longer",
                    ),
                    Text(errorMessage),
                    Consumer<DataStorage>(
                        builder: (_, data, __) => RaisedButton(
                            child:
                                loginOrSignUp ? Text("Sign up") : Text("Login"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                pr.show().then((value) {
                                  doLoginOrSignUp(tc1.text, tc2.text)
                                      .then((value) {
                                    data.currentUser = value.user;
                                    Navigator.of(context).pop();
                                    //print(value.user.email);
                                  }).catchError((e) {
                                    //print("Error");
                                    errorMessage = e.message;
                                    setState(() {});
                                  }).whenComplete(() {
                                    //print("whenComplete");
                                    pr.hide();
                                  });
                                });
                              }
                            }))
                  ],
                ))));
  }

  Future<AuthResult> doLoginOrSignUp(String email, String pw) {
    Future<AuthResult> authRes;
    if (loginOrSignUp) {
      authRes = utils.UserSignUp(email, pw);
    } else {
      authRes = utils.UserLogin(email, pw);
    }
    return authRes;
  }
}