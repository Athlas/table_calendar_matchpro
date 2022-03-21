import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduledActivity {
  // ignore: non_constant_identifier_names
  String activity_id = "";
  String date = "";
  List days = [];
  bool isUnique = false;
  List time = [];

  ScheduledActivity(Map<String, dynamic> map) {
    activity_id = map['activity_id'];
    date = map['date'];
    days = map['days'];
    isUnique = map['isUnique'];
    time = map['time'];
  }
}