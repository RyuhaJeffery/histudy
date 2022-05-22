import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_page_setting_controller.dart';

class MyPageSettingView extends GetView<MyPageSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPageSettingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyPageSettingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
