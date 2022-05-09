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
                    '글쓴이',
                  ),
                ),
                DataColumn(
                  label: Text(
                    '최신 보고서 날짜',

                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('1')),
                    DataCell(Text('안녕하세요. 관리자 입니다. ')),
                    DataCell(Text('관리자')),
                    DataCell(Text('2022-10-23')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('2')),
                    DataCell(Text('전전 스터디 보고서 등록 수칙')),
                    DataCell(Text('관리자')),
                    DataCell(Text('2022-10-23')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('3')),
                    DataCell(Text('마일리지 인정 기준 안내합니다.' )),
                    DataCell(Text('관리자')),
                    DataCell(Text('2022-10-23')),
                  ],
                ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}