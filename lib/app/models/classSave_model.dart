import 'package:cloud_firestore/cloud_firestore.dart';

class ClassSaveModel {
  String? className;
  String? code;
  String? professor;
  int? sem;
  int? year;
  String? classId;
  int? score;

  ClassSaveModel(
      {this.className,
      this.code,
      this.professor,
      this.sem,
      this.year,
      this.classId,
      this.score});
}
