import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/announce_controller.dart';

class AnnounceView extends GetView<AnnounceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnnounceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AnnounceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
