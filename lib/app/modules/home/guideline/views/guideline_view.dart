import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/guideline_controller.dart';

class GuidelineView extends GetView<GuidelineController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GuidelineView'),
        centerTitle: true,

      ),
      body: Center(
        child: Text(
          'GuidelineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
