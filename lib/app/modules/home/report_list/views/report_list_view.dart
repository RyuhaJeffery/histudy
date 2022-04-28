import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_list_controller.dart';

class ReportListView extends GetView<ReportListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReportListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ReportListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
