import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/models/group_model.dart';
import 'package:histudy/app/repository/group_repository.dart';
import 'package:histudy/app/repository/report_repository.dart';
import 'package:histudy/app/repository/user_repository.dart';
import 'package:histudy/app/routes/app_pages.dart';
import 'package:histudy/app/services/auth_service.dart';

import '../../../../models/profile_model.dart';
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
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //SizedBox(width: 180,),
                Text(
                  '등록된 스터디모임 보고서',
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
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff04589C),
                          side: BorderSide(width: 1),
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                        },
                        child: Text('보고서 작성')),
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
                      '작성 일자',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('운영체제 chapter 2 예습')),
                      DataCell(Text('이사나')),
                      DataCell(Text('2022/05/02')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('운영체제 chapter 6 복습')),
                      DataCell(Text('김길동')),
                      DataCell(Text('2022/06/09')),
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

  _reportList() {
    return FutureBuilder<ProfileModel?>(
      future: UserRepositroy.getUser(AuthService.to.auth.value.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProfileModel profile = snapshot.data!;
          return FutureBuilder<List<ReportModel>>(
            future: ReportRepository.getReportList(profile.group!.toString()),
            builder: (contextTwo, reportListSnapshot) {
              if (reportListSnapshot.hasData) {
                List<ReportModel> reportList = reportListSnapshot.data!;
                print(reportList);
                return Expanded(
                  child: ListView.builder(
                    itemCount: reportList.length,
                    itemBuilder: (BuildContext contextThree, int index) {
                      return _reportBlock(reportList[index], index);
                    },
                  ),
                );
              } else {
                return Container(height : 400.h, width: 400.w ,child: Center(child: CircularProgressIndicator()));
              }
            },
          );
        } else {
          return Container(height : 400.h, width: 400.w ,child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  _reportBlock(ReportModel reportModel, int index) {
    return Container(
      height: 50.h,
      width: 1400.w,
      child: Row(
        children: [
          Text(reportModel.title.toString()),
        ],
      ),
    );
  }
}
