import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:histudy/app/models/report_model.dart';

class ReportRepository {
  static final reportCollection = FirebaseFirestore.instance.collection('Report');

  static Future<List<ReportModel>> getReportList() async {
    List<ReportModel> userList = [];
    try {
      await reportCollection.doc().get().then((DocumentSnapshot ds) {
      });
    } catch (e) {
      Get.snackbar('Error getting user list', e.toString());
    }
    return userList;
  }
}