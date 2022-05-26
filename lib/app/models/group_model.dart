import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  int? meeting;
  List? members;
  int? no;
  int? sem;
  int? time;
  int? year;
  int? count;

  GroupModel({
    this.meeting,
    this.members,
    this.no,
    this.sem,
    this.time,
    this.year,
    this.count
  });

  GroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : meeting = snapshot['meeting'],
        members = snapshot['members'],
        no = snapshot['no'],
        sem = snapshot['sem'],
        time = snapshot['time'],
        year = snapshot['year'],
        count = snapshot['count'];
}