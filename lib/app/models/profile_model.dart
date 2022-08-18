import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  bool? classRegister;
  String? email;
  String? uid;
  int? group;
  bool? isAdmin;
  String? name;
  String? phone;
  String? studentNumber;
  List? myClasses;
  String? semId;
  String? studentId;
  bool added = false;

  ProfileModel({
    this.classRegister,
    this.email,
    this.uid,
    this.group,
    this.isAdmin,
    this.name,
    this.phone,
    this.studentNumber,
    this.myClasses,
    this.semId,
  });

  ProfileModel.fromSnapshot(DocumentSnapshot snapshot)
      : classRegister = snapshot['classRegister'],
        email = snapshot['email'],
        uid = snapshot['uid'],
        group = snapshot['group'],
        isAdmin = snapshot['isAdmin'],
        name = snapshot['name'],
        phone = snapshot['phone'],
        studentNumber = snapshot['studentNumber'],
        myClasses = snapshot['myClasses'];

  List<ProfileModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return ProfileModel(
        classRegister: dataMap['classRegister'],
        email: dataMap['email'],
        uid: dataMap['uid'],
        group: dataMap['group'],
        isAdmin: dataMap['isAdmin'],
        name: dataMap['name'],
        phone: dataMap['phone'],
        studentNumber: dataMap['studentNumber'],
        myClasses: dataMap['myClasses'],
      );
    }).toList();
  }
}
