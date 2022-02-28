import 'package:cloud_firestore/cloud_firestore.dart';

class ClosedDay {
  // ignore: non_constant_identifier_names
  String message = "";
  String date = "";

  ClosedDay(DocumentSnapshot? snapshot) {
    if(snapshot != null) {
      Map map = snapshot.data() as Map<dynamic, String>;
      message = map['message'];
      date = map['date'];
    }
  }
}