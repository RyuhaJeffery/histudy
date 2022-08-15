import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histudy/app/models/year_model.dart';

class YearRepository {
  static final yearCollection = FirebaseFirestore.instance.collection("year");

  static Future<YearModel?> getYear(String uid) async {
    var ds = await yearCollection.doc(uid).get();
    return YearModel.fromSnapshot(ds);
  }
}
