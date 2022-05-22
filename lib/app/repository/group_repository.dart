import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/group_model.dart';

class GroupRepository {
  static final reportCollection = FirebaseFirestore.instance.collection('Group');

  static Future<List<GroupModel>> getGroupList(String groupNum) async {
    List<GroupModel> groupList = [];
    try {
      await reportCollection.doc(groupNum).get().then((DocumentSnapshot ds) {
      });
    } catch (e) {
      Get.snackbar('Error getting user list', e.toString());
    }
    return groupList;
  }
}