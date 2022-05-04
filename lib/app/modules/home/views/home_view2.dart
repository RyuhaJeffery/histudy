import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../controllers/home2_controller.dart';
import '../controllers/home_controller.dart';

class HomeView2 extends GetView<Home2Controller> {

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
          child:Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  //SizedBox(width: 180,),
                  Text('등록된 스터디모임 보고서'),
                  SizedBox(width: 200,),
                  ElevatedButton(onPressed: (){
                    Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                  }, child: const Text('보고서 작성'))
                ]
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    ' ',

                  ),
                ),
                DataColumn(
                  label: Text(
                    '제목',

                  ),
                ),
                DataColumn(
                  label: Text(
                    '작성자',
                  ),
                ),
                DataColumn(
                  label: Text(
                    '날짜',

                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('1')),
                    DataCell(Text('개념 2 스터디 ')),
                    DataCell(Text('홍길동')),
                    DataCell(Text('2022-10-22')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('2')),
                    DataCell(Text('개념 3 스터디')),
                    DataCell(Text('김길동')),
                    DataCell(Text('2022-10-23')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('3')),
                    DataCell(Text('개념 4 스터디 Lec10' )),
                    DataCell(Text('관리자')),
                    DataCell(Text('2022-10-23')),
                  ],
                ),
              ],
            ),
          ],
          ),
        ),
      ]
      ),
    );
  }
}