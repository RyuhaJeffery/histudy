import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/repository/report_repository.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../../models/report_model.dart';
import '../controllers/home2_controller.dart';

class Home2View extends GetView<Home2Controller> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/handong_logo.png')),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.rootDelegate.toNamed(Routes.HOME);
                  },
                  child: Text(
                    'HISTUDY',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.HOME2);
                    },
                    child: Text("HOME")),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.GROUP_INFO);
                    },
                    child: Text("TEAM")),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.QUESTION);
                    },
                    child: Text("Q&A")),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.ANNOUNCE);
                    },
                    child: Text("ANNOUNCEMENT")),
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.RANK);
                    },
                    child: Text("RANK")),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.GUIDELINE);
                    },
                    child: Text("GUIDELINE")),
                ElevatedButton(onPressed: () {
                  Get.rootDelegate.toNamed(Routes.MY_PAGE);
                }, child: Text('MY PAGE'))
              ],
            ),
          ]),
        ),
        Container(
          width: 1500,
          child:Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  //SizedBox(width: 180,),
                  Text('등록된 스터디모임 보고서'),
                  ElevatedButton(onPressed: (){
                    Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                  }, child: const Text('보고서 작성'))
                ]
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
            Divider(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                Text(""),
                SizedBox(
                  width: 400,
                ),
                Text("제목"),
                SizedBox(
                  width: 350,
                ),
                Text("작성자"),
                SizedBox(
                  width: 350,
                ),
                Text("날짜"),
                SizedBox(
                  width: 200,
                ),
              ],
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
      ]
      ),
    );
  }

  _reportBlock(ReportModel reportModel) {}
}