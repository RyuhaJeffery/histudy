import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/profile_model.dart';

class UserRepositroy {
  static final userCollection = FirebaseFirestore.instance.collection('Profile');

  static Future<ProfileModel> getUser(String uid) async {
    ProfileModel userModel = ProfileModel();
    try {
      await userCollection.doc(uid).get().then((DocumentSnapshot ds) {
        if (kDebugMode) {
          print('getUser');
        }
        userModel = ProfileModel.fromSnapshot(ds);
      });
    } catch (e) {
      print("error");
    }
    return userModel;
  }
}