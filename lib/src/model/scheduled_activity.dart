import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduledActivity {
  // ignore: non_constant_identifier_names
  String activity_id = "";
  String date = "";
  List days = [];
  bool isUnique = false;
  List time = [];

  ScheduledActivity(DocumentSnapshot? snapshot) {
    if(snapshot != null) {
      Map map = snapshot.data() as Map<dynamic, String>;
      activity_id = map['activity_id'];
      date = map['date'];
      days = map['days'];
      isUnique = map['isUnique'];
      time = map['time'];
    }
  }
}