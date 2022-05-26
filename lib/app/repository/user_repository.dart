import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/profile_model.dart';

class UserRepositroy {
  static final userCollection = FirebaseFirestore.instance.collection('Profile');

  static Future<ProfileModel?> getUser(String uid) async {
      var ds = await userCollection.doc(uid).get();
      return ProfileModel.fromSnapshot(ds);
  }
}