import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/models/profile_model.dart';
import 'package:histudy/app/models/report_model.dart';
import 'package:histudy/app/repository/user_repository.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import '../controllers/report_detail_controller.dart';

class ReportDetailView extends GetView<ReportDetailController> {
  @override
  Widget build(BuildContext context) {
    ReportModel reportModel = controller.arg;
    print(reportModel.image.toString());
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              topBar(Get.rootDelegate.parameters["semId"], context),
              SizedBox(
                height: 22.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                height: 1040,
                width: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _titleWidget('제목'),
                              SizedBox(
                                width: 16.w,
                              ),
                              Text(
                                reportModel.title.toString(),
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          _titleWidget('참여 멤버'),
                          SizedBox(
                            width: 16.h,
                          ),
                          Container(
                            height: 50.h,
                            width: 400.w,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: reportModel.participants!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder<ProfileModel?>(
                                      future: UserRepositroy.getUser(reportModel
                                          .participants![index]
                                          .toString()),
                                      builder: (context, userSnapshot) {
                                        if (userSnapshot.hasData) {
                                          ProfileModel profileModelInGroup =
                                              userSnapshot.data!;
                                          return index ==
                                                  reportModel.participants!
                                                          .length -
                                                      1
                                              ? Text(profileModelInGroup.name
                                                  .toString())
                                              : Text(profileModelInGroup.name
                                                      .toString() +
                                                  ", ");
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          _titleWidget('스터디 시작 시간'),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            '${reportModel.studyStartTime} ' +
                                '(${reportModel.duration}분간 진행)',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      _dividerWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleWidget('스터디 내용'),
                          SizedBox(
                            width: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: Text(
                              reportModel.text.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleWidget('이미지'),
                          SizedBox(
                            width: 54.w,
                          ),
                          Image.network(
                            reportModel.image.toString(),
                            height: 350.h,
                            width: 350.w,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ), // 이미지 추
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 14, color: Colors.black87),
    );
  }

  Widget _dividerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Container(
          height: 1,
          color: Colors.black54,
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
