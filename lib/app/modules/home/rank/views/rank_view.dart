import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

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
               topBar(),
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //SizedBox(width: 180,),
                  Text(
                    '랭 킹',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ]),
                SizedBox(
                  height: 30,
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