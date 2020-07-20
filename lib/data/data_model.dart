import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_exchange/data/user_record.dart';

class DataStorage with ChangeNotifier, DiagnosticableTreeMixin {
  FirebaseUser _currentUser;
  UserRecord userProfile;

  FirebaseUser get currentUser => _currentUser;
  set currentUser(FirebaseUser user) {
    _currentUser = user;
    this.notifyListeners();
  }
}
