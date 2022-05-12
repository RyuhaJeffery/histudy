import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  int? meeting;
  List<String>? members;
  int? no;
  int? sem;
  int? time;
  int? year;

  GroupModel({
    this.meeting,
    this.members,
    this.no,
    this.sem,
    this.time,
    this.year,
  });

  GroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : meeting = snapshot['meeting'],
        members = snapshot['members'],
        no = snapshot['no'],
        sem = snapshot['sem'],
        time = snapshot['time'],
        year = snapshot['year'];
}