class UserRecord {
  String contact;

  UserRecord(Map<String, dynamic> rawMap) {
    contact = rawMap['contact'];
  }
}
