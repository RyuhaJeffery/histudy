import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:histudy/app/models/report_model.dart';

class ReportRepository {
  // static final reportCollection =
  //     FirebaseFirestore.instance.collection('Report');
  // static final groupCollection = FirebaseFirestore.instance.collection('Group');

  static Stream<QuerySnapshot> getReportList(String semId, String group) {
    final groupCollection = FirebaseFirestore.instance
        .collection(semId)
        .doc(semId)
        .collection('Group');
    return groupCollection.doc(group).collection('reports').snapshots();
  }

  static uploadReport(
      String semId,
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
      String title) async {
    final groupCollection = FirebaseFirestore.instance
        .collection(semId)
        .doc(semId)
        .collection('Group');

    await groupCollection
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
      'participants': participants.toSet().toList(),
      'studyStartTime': studyStartTime,
      'text': text,
      'title': title,
    }).then((value) {
      groupCollection.doc(group).update({
        'time': FieldValue.increment(int.parse(duration)),
        'meeting': FieldValue.increment(1)
      }).then((value) {
        for (int i = 0; i < participants.toSet().toList().length; i++) {
          FirebaseFirestore.instance
              .collection("Profile")
              .doc(participants[i])
              .update({
            "${semId}_time": FieldValue.increment(int.parse(duration)),
            "${semId}_meeting": FieldValue.increment(1)
          });
          Future.delayed(Duration(seconds: 1));
        }
      });
    });

    await groupCollection.doc(group).update({
      'imageUrl': image,
    });

    Get.snackbar("보고서 업로드 완료", "리스트를 확인하세요");
  }
}
