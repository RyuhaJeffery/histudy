import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_write_controller.dart';

class ReportWriteView extends GetView<ReportWriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReportWriteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ReportWriteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
