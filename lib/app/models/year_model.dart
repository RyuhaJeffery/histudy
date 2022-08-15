import 'package:cloud_firestore/cloud_firestore.dart';

class YearModel {
  int? year;
  int? semester;
  bool? thisSem;

  YearModel({this.year, this.semester, this.thisSem});

  YearModel.fromSnapshot(DocumentSnapshot snapshot)
      : year = snapshot['year'],
        semester = snapshot['semester'],
        thisSem = snapshot['thisSem'];
}
