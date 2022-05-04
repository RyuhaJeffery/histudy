import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';

class MyPageView extends GetView<MyPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
