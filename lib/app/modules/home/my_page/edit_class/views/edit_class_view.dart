import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_class_controller.dart';

class EditClassView extends GetView<EditClassController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditClassView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditClassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
