import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
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
                  Text('Q&A 게시판'),
                  SizedBox(width: 200,),
                  ElevatedButton(onPressed: (){
                    Get.rootDelegate.toNamed(Routes.QUESTION_WRITE);
                  }, child: const Text('질문 작성'))
                ]
            ),



            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'No',

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
                    '과목',

                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('1')),
                    DataCell(Text('저는 아는게 없습니다 ..  ')),
                    DataCell(Text('홍길동')),
                    DataCell(Text('소프트웨어 공학')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('2')),
                    DataCell(Text('DB Query 질문있어요!')),
                    DataCell(Text('김길동')),
                    DataCell(Text('데이터베이스')),
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