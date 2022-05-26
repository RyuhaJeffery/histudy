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
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          topBar(),
          SizedBox(height: 30.h,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '등록된 스터디모임 보고서',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                },
                child: const Text('보고서 작성')),
          ]),
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
          _reportList(),
        ]),
      ),
    );
  }

  _reportList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              width: 100.w,
              child: Center(
                child: Text(
                  'NO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 100.w,
              child: Center(
                child: Text(
                  'TITLE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 100.w,
              child: Center(
                child: Text(
                  'AUTHOR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 130.w,
              child: Center(
                child: Text(
                  'DATE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        FutureBuilder<ProfileModel?>(
          future: UserRepositroy.getUser(AuthService.to.auth.value.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProfileModel profile = snapshot.data!;

              return StreamBuilder<QuerySnapshot>(
                stream: ReportRepository.getReportList(profile.group!.toString()),
                builder: (contextTwo, reportListSnapshot) {
                  if (reportListSnapshot.hasData) {
                    List<ReportModel> reportList = reportListSnapshot.data!.docs.map((item) => ReportModel.fromSnapshot(item)).toList();
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
                    return Container(height : 400.h, width: 400.w ,child: Center(child: CircularProgressIndicator()));
                  }
                },
              );
            } else {
              return Container(height : 400.h, width: 400.w ,child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ],
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
              width: 100.w,
              child: Center(
                child: Text(
                  '${index+1}'.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 100.w,
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
                  DateFormat('yyyy-MM-dd').format(reportModel.dateTime!.toDate()),
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
