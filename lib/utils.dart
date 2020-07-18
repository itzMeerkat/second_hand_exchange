import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<AuthResult> UserSignUp(String email, String pw) {
  return FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: pw);
}

Future<AuthResult> UserLogin(String email, String pw) {
  return FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: pw);
}
