import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/announce_controller.dart';

class AnnounceView extends GetView<AnnounceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child:
        Container(
          child:Column(children: [
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

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  SizedBox(width: 150,),
                  Text('공지사항'),]
            ),




          ],
          ),
        ),
      ),
    );
  }
}