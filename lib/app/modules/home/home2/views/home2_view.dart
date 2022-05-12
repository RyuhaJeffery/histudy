import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/repository/report_repository.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../../models/report_model.dart';
import '../../../../widgets/top_bar_widget.dart';
import '../controllers/home2_controller.dart';

class Home2View extends GetView<Home2Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Column(children: [
        topBar(),
        Container(
          width: 1400,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //SizedBox(width: 180,),
                Text('등록된 스터디모임 보고서'),
                ElevatedButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                    },
                    child: const Text('보고서 작성'))
              ]),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  _reportBlock(ReportModel reportModel) {}
}
