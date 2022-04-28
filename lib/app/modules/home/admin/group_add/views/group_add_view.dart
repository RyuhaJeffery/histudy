import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/group_add_controller.dart';

class GroupAddView extends GetView<GroupAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GroupAddView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GroupAddView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
