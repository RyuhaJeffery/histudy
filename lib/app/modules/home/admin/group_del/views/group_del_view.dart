import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/group_del_controller.dart';

class GroupDelView extends GetView<GroupDelController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GroupDelView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GroupDelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
