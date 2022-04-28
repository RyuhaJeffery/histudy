import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_list_controller.dart';

class StudentListView extends GetView<StudentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudentListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudentListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
