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
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Column(
            children: [
              topBar(),
              SizedBox(
                height: 22.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                height: 700.h,
                width: 774.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                child: ListView(
                  children: [
                    Column(
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
                                  style:
                                      TextStyle(fontSize: 15.sp, color: Colors.black),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                  Icons.clear
                              )
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            _titleWidget('참여 멤버'),
                            SizedBox(
                              width: 16.h,
                            ),
                            Container(
                              height: 50.h,
                              width: 550.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: reportModel.participants!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FutureBuilder<ProfileModel?>(
                                        future: UserRepositroy.getUser(reportModel.participants![index].toString()),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.hasData) {
                                            ProfileModel profileModelInGroup = userSnapshot.data!;
                                            return index == reportModel.participants!.length-1 ?
                                              Text(profileModelInGroup.name.toString()) :
                                              Text(profileModelInGroup.name.toString()+", ");
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                      SizedBox(width: 10.w,)
                                    ],
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
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
                              child: Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 50,
                                    text: TextSpan(
                                  text: reportModel.text.toString(),
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.black),
                                )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleWidget('이미지'),
                            SizedBox(width: 54.w,),
                            Image.network(
                              reportModel.image.toString(),
                              height: 350.h,
                              width: 350.w,
                              fit: BoxFit.cover
                            ),
                          ],
                        ), // 이미지 추
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _titleWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget _dividerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
