import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rank_controller.dart';

class RankView extends GetView<RankController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RankView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RankView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
