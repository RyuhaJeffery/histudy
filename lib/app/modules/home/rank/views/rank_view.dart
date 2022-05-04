import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/rank_controller.dart';

class RankView extends GetView<RankController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
          child: Container (
              child : Column(children: [
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
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        ' ',

                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '그룹 번호',

                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '보고서 수',

                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '최신 보고서 날짜',

                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '누적 공부 시간(분)',

                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('1')),
                        DataCell(Text('Group 1')),
                        DataCell(Text('19')),
                        DataCell(Text('2022-10-23')),
                        DataCell(Text('123')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('2')),
                        DataCell(Text('Group 2')),
                        DataCell(Text('15')),
                        DataCell(Text('2022-10-23')),
                        DataCell(Text('122')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('3')),
                        DataCell(Text('Group 3')),
                        DataCell(Text('10')),
                        DataCell(Text('2022-10-23')),
                        DataCell(Text('120')),
                      ],
                    ),

                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(width: 300,height: 10,),
                //   ElevatedButton(onPressed: (){}, child: const Text('그룹 추가')),
                //   const SizedBox(width: 10,height: 10,),
                //   ElevatedButton(onPressed: (){}, child: const Text('그룹 삭제'))

                // ])
              ])

          )
      ),
    );
  }
}