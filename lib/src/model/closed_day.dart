import 'package:cloud_firestore/cloud_firestore.dart';

class ClosedDay {
  // ignore: non_constant_identifier_names
  String message = "";
  String date = "";

  ClosedDay(Map<String, dynamic> map) {
    message = map['message'];
    date = map['date'];
  }
}