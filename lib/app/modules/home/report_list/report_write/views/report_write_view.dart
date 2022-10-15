import 'dart:io';
import 'dart:math';
import 'dart:html' as html;

import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/models/group_model.dart';
import 'package:histudy/app/models/profile_model.dart';
import 'package:histudy/app/repository/group_repository.dart';
import 'package:histudy/app/repository/report_repository.dart';
import 'package:histudy/app/repository/user_repository.dart';
import 'package:histudy/app/services/auth_service.dart';
import 'package:histudy/app/services/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/report_write_controller.dart';

// Report 추가 할 때, 총 시간 값을 Group field로 만들어 duration을 더해주기

class ReportWriteView extends GetView<ReportWriteController> {
  var imagePickerService = ImagePickerService();
  XFile? pickedImage;
  RxBool isImagePicked = false.obs;
  List<String> finalCheckedMembers = [];
  RxString startingTime = ''.obs;
  RxString code = ''.obs;
  String duration = '';
  String title = '';
  String contents = '';

  DateTime makingCodeTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileModel?>(
        future:
            UserRepositroy.getUser(AuthService.to.auth.value.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileModel profile = snapshot.data!;
            profile.semId = Get.rootDelegate.parameters['semId'];

            return Scaffold(
                backgroundColor: Color(0xffFDFFFE),
                body: ListView(
                  children: [
                    Column(
                      children: [
                        topBar(Get.rootDelegate.parameters["semId"], context),
                        _sizedBoxWidget(22),
                        _mainTitleWidget(),
                        _sizedBoxWidget(22),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          height: 1100.h,
                          width: 700.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _subTitleWidget(
                                  '인증샷 올리기 (* 파일명에 한글이 들어가면 오류가 날 수 있음)'),
                              _sizedBoxWidget(16),
                              _imageUploadWidget(profile),
                              _sizedBoxWidget(20),
                              _divideWidget(),
                              _sizedBoxWidget(20),
                              _createCodeWidget(),
                              _sizedBoxWidget(20),
                              _divideWidget(),
                              _sizedBoxWidget(20),
                              _subTitleWidget('참여 멤버'),
                              _participantsWidget(profile),
                              _divideWidget(),
                              _sizedBoxWidget(20),
                              _subTitleWidget('스터디 시작 시간 입력'),
                              _sizedBoxWidget(20),
                              _startTimeInputWidget(),
                              _sizedBoxWidget(20),
                              _subTitleWidget('스터디 시간 입력(분단위)'),
                              _sizedBoxWidget(20),
                              _durationInputWidget(),
                              _sizedBoxWidget(20),
                              _divideWidget(),
                              _sizedBoxWidget(20),
                              _subTitleWidget('스터디 제목'),
                              _sizedBoxWidget(20),
                              _studyTitleInputWidget(),
                              _sizedBoxWidget(20),
                              _subTitleWidget('스터디 내용'),
                              _sizedBoxWidget(20),
                              _contentsInputWidget(),
                              _sizedBoxWidget(30),
                              _bottomButtons(profile),
                            ],
                          ),
                        ),
                        _sizedBoxWidget(30),
                      ],
                    ),
                  ],
                ));
          } else {
            return Container(
                height: 400.h,
                width: 400.w,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _mainTitleWidget() {
    return Text(
      '스터디모임 보고서 작성',
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87),
    );
  }

  Widget _subTitleWidget(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget _imageUploadWidget(ProfileModel profile) {
    return InkWell(
      child: Obx(() {
        return isImagePicked.value == true
            ? Container(
                height: 20.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: Color(0xff04589C),
                    border: Border.all(width: 1, color: Color(0xff04589C)),
                    borderRadius: BorderRadius.all(Radius.circular(3.r))),
                child: Center(
                  child: Text(
                    '사진 촬영/이미지 업로드',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              )
            : Container(
                height: 20.h,
                width: 200.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xff04589C)),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Center(
                  child: Text(
                    '사진 촬영/이미지 업로드',
                    style: TextStyle(
                      color: Color(0xff04589C),
                      fontSize: 11,
                    ),
                  ),
                ),
              );
      }),
      onTap: () async {
        pickedImage = await imagePickerService.pickImage();
        if (pickedImage.isNull) {
          isImagePicked.value = false;
        } else {
          isImagePicked.value = true;
        }
      },
    );
  }

  Widget _divideWidget() {
    return Container(
      height: 1,
      width: 800.sp,
      color: Colors.black26,
    );
  }

  Widget _createCodeWidget() {
    return InkWell(
      child: Container(
        height: 30.h,
        width: 120.w,
        decoration: BoxDecoration(
            color: Color(0xff04589C),
            borderRadius: BorderRadius.all(Radius.circular(3.r))),
        child: Center(
          child: Text(
            '코드 생성',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
            ),
          ),
        ),
      ),
      onTap: () {
        code.value = getRandomString(5);
        Get.dialog(AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Code",
              ),
              InkWell(
                child: Icon(Icons.clear),
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
          content: Container(
            height: 800.h,
            width: 1200.w,
            child: Center(
              child: Text(
                code.toString(),
                style: TextStyle(fontSize: 300.sp),
              ),
            ),
          ),
        ));
        makingCodeTime = DateTime.now();
        print(makingCodeTime);
      },
    );
  }

  Widget _participantsWidget(ProfileModel profileModel) {
    if (profileModel.semId != null) {
      return FutureBuilder<GroupModel?>(
          future: GroupRepository.getGroup(
              profileModel.semId, profileModel.group!.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              GroupModel groupModel = snapshot.data!;

              double heightTemp = groupModel.members!.length * 35;

              return Container(
                height: heightTemp,
                child: ListView.builder(
                  itemCount: groupModel.members!.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<RxBool> _isCheckedList = List<RxBool>.filled(
                        groupModel.members!.length, false.obs,
                        growable: true);
                    return Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                              value: _isCheckedList[index].value,
                              onChanged: (value) {
                                _isCheckedList[index].value == true
                                    ? _isCheckedList[index].value = false
                                    : _isCheckedList[index].value = true;
                                value == true
                                    ? finalCheckedMembers
                                        .add(groupModel.members![index])
                                    : finalCheckedMembers.removeWhere((item) =>
                                        item == groupModel.members![index]);

                                print(finalCheckedMembers);
                              }),
                          FutureBuilder<ProfileModel?>(
                            future: UserRepositroy.getUser(
                                groupModel.members![index].toString()),
                            builder: (context, profileSnapshot) {
                              if (profileSnapshot.hasData) {
                                ProfileModel profileModelInGroup =
                                    profileSnapshot.data!;
                                return Text(
                                    profileModelInGroup.name.toString());
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      );
                    });
                  },
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    } else {
      return Text("학기 정보가 존재하지 않습니다. 홈에서 새로고침 후 다시 작성하십사오");
    }
  }

  Widget _startTimeInputWidget() {
    return Obx(() {
      return DateTimePicker(
        type: DateTimePickerType.time,
        initialValue: startingTime.value,
        icon: Icon(Icons.access_time),
        timeLabelText: 'Starting Time',
        use24HourFormat: true,
        locale: Locale('en', 'US'),
        onChanged: (value) {
          startingTime.value = value;
        },
      );
    });
  }

  Widget _durationInputWidget() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '수행 시간을 입력하세요.(분 단위로 숫자만 입력하여 주세요.)',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFECEFF1)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: (value) {
        duration = value;
      },
    );
  }

  Widget _studyTitleInputWidget() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      decoration: InputDecoration(
        hintText: '제목을 입력하세요.',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFECEFF1)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: (value) {
        title = value;
      },
    );
  }

  Widget _contentsInputWidget() {
    return Expanded(
      child: TextFormField(
        maxLines: 50,
        initialValue: contents,
        decoration: InputDecoration(
          hintText: '내용을 입력하세요.',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onChanged: (value) {
          contents = value;
        },
      ),
    );
  }

  Widget _sizedBoxWidget(int value) {
    return SizedBox(
      height: value.h,
    );
  }

  Widget _bottomButtons(ProfileModel profileModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 8,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 35,
                child: Center(
                    child: Text(
                  "취 소",
                  style: TextStyle(color: Colors.white),
                ))),
            onPressed: () async {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black26,
              //   onPrimary: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD1C4E9),
                spreadRadius: 8,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 35,
                child: Center(child: Text("작 성"))),
            onPressed: () async {
              if (DateTime.now().difference(makingCodeTime).inMinutes > 10) {
                Get.snackbar('코드를 생성해주세요',
                    '코드 생성 후 10분내로 업로드 하셔야 합니다. 다시 코드를 생성해서 인증샷을 찍어주세요');
              } else {
                if (code.isEmpty) {
                  Get.snackbar('코드를 생성해 주세요', '코드와 함께 인증샷을 찍어야 합니다.');
                } else if (finalCheckedMembers.isEmpty ||
                    startingTime.isEmpty ||
                    duration.isEmpty ||
                    title.isEmpty ||
                    contents.isEmpty ||
                    pickedImage.isNull) {
                  Get.snackbar('다시 시도하세요', '모든 항목을 채우셔야 합니다. 합니다.');
                } else {
                  String? semId = Get.rootDelegate.parameters['semId'];
                  if (semId != null) {
                    await Get.snackbar('보고서 업로드를 시작합니다.', '잠시만 기다려 주세요');
                    DateTime dateTime = await DateTime.now();
                    // print("[RW]" + dateTime.toString());
                    await imagePickerService.uploadImage(pickedImage!,
                        profileModel.group.toString(), dateTime.toString());
                    String imageUrl = await imagePickerService.downloadURL(
                        profileModel.group.toString(), dateTime.toString());
                    // print("[RW]" + imageUrl);
                    await ReportRepository.uploadReport(
                        semId,
                        profileModel.name.toString(),
                        code.toString(),
                        makingCodeTime,
                        dateTime,
                        duration,
                        profileModel.group.toString(),
                        imageUrl,
                        finalCheckedMembers,
                        startingTime.toString(),
                        contents,
                        title);
                    await Get.rootDelegate.toNamed(Routes.REPORT_LIST);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
