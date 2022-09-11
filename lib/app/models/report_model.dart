import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? author;
  String? code;
  Timestamp? codeDatetime;
  Timestamp? dateTime;
  int? duration;
  String? group;
  String? image;
  List? participants;

  String? studyStartTime;
  String? text;
  String? title;

  ReportModel(
      {this.author,
      this.code,
      this.codeDatetime,
      this.dateTime,
      this.duration,
      this.group,
      this.image,
      this.participants,
      this.studyStartTime,
      this.text,
      this.title});

  ReportModel.fromSnapshot(DocumentSnapshot snapshot)
      : author = snapshot['author'],
        code = snapshot['code'],
        codeDatetime = snapshot['codeDatetime'],
        dateTime = snapshot['dateTime'],
        duration = snapshot['duration'],
        group = snapshot['group'],
        image = snapshot['image'],
        participants = snapshot['participants'],
        studyStartTime = snapshot['studyStartTime'],
        text = snapshot['text'],
        title = snapshot['title'];

  List<ReportModel> reportListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> ReportMap =
          snapshot.data() as Map<String, dynamic>;

      return ReportModel(
          author: ReportMap['author'],
          code: ReportMap['code'],
          codeDatetime: ReportMap['codeDatetime'],
          dateTime: ReportMap['dateTime'],
          duration: ReportMap['duration'],
          group: ReportMap['group'],
          image: ReportMap['image'],
          participants: ReportMap['participants'],
          studyStartTime: ReportMap['studyStartTime'],
          text: ReportMap['text'],
          title: ReportMap['title']);
    }).toList();
  }
}
