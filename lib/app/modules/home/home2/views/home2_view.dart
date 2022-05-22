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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('등록된 스터디모임 보고서'),
                ElevatedButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.REPORT_WRITE);
                    },
                    child: const Text('보고서 작성'))
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
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.black,
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
