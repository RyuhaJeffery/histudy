import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:get/get.dart';
import 'package:histudy/app/models/report_model.dart';

class ReportRepository {
  static final reportCollection =
      FirebaseFirestore.instance.collection('Report');
  static final groupCollection = FirebaseFirestore.instance.collection('Group');

  static Stream<QuerySnapshot> getReportList(String group) {
    return groupCollection.doc(group).collection('reports').snapshots();
  }

  static uploadReport(
      String author,
      String code,
      DateTime codeDatetime,
      DateTime dateTime,
      String duration,
      String group,
      String image,
      List<String> participants,
      String studyStartTime,
      String text,
      String title) {
    groupCollection
        .doc(group)
        .collection("reports")
        .doc(dateTime.toString())
        .set({
      'author': author,
      'code': code,
      'codeDatetime': codeDatetime,
      'dateTime': dateTime,
      'duration': int.parse(duration),
      'group': group,
      'image': image,
      'participants': participants,
      'studyStartTime': studyStartTime,
      'text': text,
      'title': title,
      'sem': "1",
      'year': "2022",
    });

    groupCollection.doc(group).update({
      'time': FieldValue.increment(int.parse(duration)),
      'meeting': FieldValue.increment(1)
    });
  }
}
