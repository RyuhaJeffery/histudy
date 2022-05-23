import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:histudy/app/models/report_model.dart';

class ReportRepository {
  static final reportCollection = FirebaseFirestore.instance.collection('Report');
  static final groupCollection = FirebaseFirestore.instance.collection('Group');

  // static Future<List<ReportModel>> getReportList(String group) async {
  //   return await groupCollection.doc(group).collection('reports').snapshots().first.then((value){
  //     return value.docs.map((item) => ReportModel.fromSnapshot(item)).toList();
  //   });
  // }

  static Future<List<ReportModel>> getReportList(String group) async {
    var k = await groupCollection
        .doc(group)
        .collection('reports')
        .get();
    return k.docs.map((item) {
      return ReportModel.fromSnapshot(item);
    }).toList();
  }

  static uploadReport(String author, String code, DateTime codeDatetime, DateTime dateTime, String duration, String group, String image, List<String> participants, String studyStartTime, String text, String title) {
    groupCollection
        .doc(group)
        .collection("reports")
        .doc(dateTime.toString())
        .set({
      'author' : author,
      'code' : code,
      'codeDatetime' : codeDatetime,
      'dateTime' : dateTime,
      'duration' : duration,
      'group' : group,
      'image' : "",
      'participants' : participants,
      'studyStartTime' : studyStartTime,
      'text' : text,
      'title' : title,
      'sem' : "1",
      'year' : "2022",
    });
  }
}