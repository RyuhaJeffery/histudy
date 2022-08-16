import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/group_model.dart';

class GroupRepository {
  static Future<GroupModel?> getGroup(String? semId, String groupNum) async {
    if (semId != null) {
      final groupCollection = FirebaseFirestore.instance
          .collection(semId)
          .doc(semId)
          .collection('Group');
      var ds = await groupCollection.doc(groupNum).get();
      return GroupModel.fromSnapshot(ds);
    }
  }
}
