import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Column(children: [
        topBar(),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //SizedBox(width: 180,),
                Text(
                  'Q&A 게시판',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black87),),

              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                  ),
                  SizedBox(
                    width: 88,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff04589C),
                          side: BorderSide(width: 1),
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Get.rootDelegate.toNamed(Routes.QUESTION_WRITE);
                        },
                        child: Text('질문 작성')),
                  ),
                ],
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
      ]),
    );
  }
}
