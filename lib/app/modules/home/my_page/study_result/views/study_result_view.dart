import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_result_controller.dart';

class StudyResultView extends GetView<StudyResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudyResultView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudyResultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
