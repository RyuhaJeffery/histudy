import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/group_model.dart';

class GroupRepository {
  static final groupCollection = FirebaseFirestore.instance.collection('Group');

  static Future<GroupModel?> getGroup(String groupNum) async {
    var ds = await groupCollection.doc(groupNum).get();
    return GroupModel.fromSnapshot(ds);
  }
}
