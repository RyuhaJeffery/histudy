import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histudy/app/modules/home/report_list/report_detail/controllers/report_detail_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../models/profile_model.dart';
import '../../../../models/report_model.dart';
import '../../../../repository/report_repository.dart';
import '../../../../repository/user_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/top_bar_widget.dart';
import '../controllers/report_list_controller.dart';
import '../report_detail/controllers/report_detail_controller.dart';

class ReportListView extends GetView<ReportListController> {
  @override
  Widget build(BuildContext context) {
    String? semId = Get.rootDelegate.parameters["semId"];
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          topBar(Get.rootDelegate.parameters["semId"]),
          SizedBox(
            height: 30.h,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //SizedBox(width: 180,),
            Text(
              "등록된 스터디모임 보고서",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
                width: 100,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff04589C),
                      side: BorderSide(width: 1),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      if (semId != null) {
                        Get.rootDelegate.toNamed(
                          Routes.REPORT_WRITE,
                          arguments: true,
                          parameters: {
                            'semId': semId,
                          },
                        );
                      }
                    },
                    child: Text('보고서 작성')),
              ),
            ],
          ),
          _reportList(),
        ]),
      ),
    );
  }

  _reportList() {
    String? semId = Get.rootDelegate.parameters['semId'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
      child: Column(
        children: [
          Divider(
            thickness: 0.1,
            color: Colors.black,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Text(
              '  No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '  제목',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '  글쓴이',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '  날짜',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          ]),
          Divider(
            thickness: 0.1,
            color: Colors.black,
            height: 10,
          ),
          FutureBuilder<ProfileModel?>(
            future: UserRepositroy.getUser(
                AuthService.to.auth.value.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && semId != null) {
                ProfileModel profile = snapshot.data!;

                return StreamBuilder<QuerySnapshot>(
                  stream: ReportRepository.getReportList(
                    semId,
                    profile.group!.toString(),
                  ),
                  builder: (contextTwo, reportListSnapshot) {
                    if (reportListSnapshot.hasData) {
                      List<ReportModel> reportList = reportListSnapshot
                          .data!.docs
                          .map((item) => ReportModel.fromSnapshot(item))
                          .toList();
//                    List<ReportModel> reportList = reportListSnapshot.data!;

                      return SizedBox(
                        height: 400.h,
                        child: ListView.builder(
                          itemCount: reportList.length,
                          itemBuilder: (BuildContext contextThree, int index) {
                            return _reportBlock(reportList[index], index);
                          },
                        ),
                      );
                    } else {
                      return Container(
                          height: 400.h,
                          width: 400.w,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                );
              } else {
                return Container(
                    height: 400.h,
                    width: 400.w,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }

  _reportBlock(ReportModel reportModel, int index) {
    return InkWell(
      onTap: () {
        Get.put(ReportDetailController()).arg = reportModel;
        Get.rootDelegate.toNamed(Routes.REPORT_DETAILE);
      },
      child: Container(
        height: 50.h,
        width: 1400.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              width: 40.w,
              child: Center(
                child: Text(
                  '${index + 1}'.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 80.w,
              child: Center(
                child: Text(
                  reportModel.title.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 100.w,
              child: Center(
                child: Text(
                  reportModel.author.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 130.w,
              child: Center(
                child: Text(
                  DateFormat('yyyy-MM-dd')
                      .format(reportModel.dateTime!.toDate()),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
