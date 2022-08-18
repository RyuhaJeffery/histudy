import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String? className;
  String? code;
  String? professor;
  int? sem;
  int? year;
  String? classId;

  ClassModel({
    this.className,
    this.code,
    this.professor,
    this.sem,
    this.year,
    this.classId,
  });

  List<ClassModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return ClassModel(
          className: dataMap['class'],
          code: dataMap['code'],
          professor: dataMap['professor'],
          sem: dataMap['semester'],
          year: dataMap['year'],
          classId: snapshot.id);
    }).toList();
  }
}
