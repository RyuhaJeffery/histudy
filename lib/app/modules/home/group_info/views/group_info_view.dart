import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/group_info_controller.dart';

class GroupInfoView extends GetView<GroupInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GroupInfoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GroupInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
