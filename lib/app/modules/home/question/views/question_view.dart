import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuestionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'QuestionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
