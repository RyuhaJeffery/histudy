import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? email;
  String? uid;
  int? group;
  bool? isAdmin;
  String? name;
  String? phone;
  String? studentNumber;
  List? myClasses;

  ProfileModel({
     this.email,
     this.uid,
     this.group,
     this.isAdmin,
     this.name,
     this.phone,
     this.studentNumber,
     this.myClasses,
  });

  ProfileModel.fromSnapshot(DocumentSnapshot snapshot)
      : email = snapshot['email'],
        uid = snapshot['uid'],
        group = snapshot['group'],
        isAdmin = snapshot['isAdmin'],
        name = snapshot['name'],
        phone = snapshot['phone'],
        studentNumber = snapshot['studentNumber'],
        myClasses = snapshot['myClasses'];
}