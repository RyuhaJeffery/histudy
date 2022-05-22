import 'dart:io';

import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/models/profile_model.dart';
import 'package:histudy/app/repository/user_repository.dart';
import 'package:histudy/app/services/auth_service.dart';
import 'package:histudy/app/services/image_picker_service.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/report_write_controller.dart';

// 1. 보고서 작성 클릭
// 2. 클릭한 CurrentUser의 Group 선택
// 3. 해당 Group의 Members를 호출해서 참석한 멤버 Check
// 4. 저장을 누르면 Group의 SubCollection에 해당 Date로 Report가 작성되어야 함

class ReportWriteView extends GetView<ReportWriteController> {
  var imagePickerService = ImagePickerService();
  File? pickedImage;
  RxBool isImagePicked = false.obs;
  final _formKey = GlobalKey<FormState>();
  bool? checkboxIconFormFieldValue = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserRepositroy.getUser(AuthService.to.auth.value.currentUser!.uid),
        builder: (context, snapshot) {
          print("야호");
          if (snapshot.hasData) {
            ProfileModel profile = snapshot.data as ProfileModel;
            return Scaffold(
                backgroundColor: Color(0xffFDFFFE),
                body: ListView(
                  children: [
                    Column(
                      children: [
                        Text(profile.name.toString()),
                        topBar(),
                        _sizedBoxWidget(22),
                        _mainTitleWidget(),
                        _sizedBoxWidget(22),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                          height: 1040.h,
                          width: 774.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.r)
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _subTitleWidget('인증샷 올리기 (* 파일명에 한글이 들어가면 오류가 날 수 있음)'),
                              _sizedBoxWidget(16),
                              _imageUploadWidget(),
                              _sizedBoxWidget(16),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _createCodeWidget(),
                              _sizedBoxWidget(16),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('참여 멤버'),
                              _participantsWidget(),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 시작 시간 입력'),
                              _sizedBoxWidget(16),
                              _startTimeInputWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 시간 입력(분단위)'),
                              _sizedBoxWidget(16),
                              _endTimeInputWidget(),
                              _sizedBoxWidget(16),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 제목'),
                              _sizedBoxWidget(16),
                              _studyTitleInputWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 내용'),
                              _sizedBoxWidget(8),
                              _contentsInputWidget(),
                              _sizedBoxWidget(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: 27,
                                      width: 68,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)
                                          )
                                      ),
                                      child: Center(
                                        child: Text(
                                          '작성',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print("Clicked");
                                    },
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: 27,
                                      width: 68,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)
                                          )
                                      ),
                                      child: Center(
                                        child: Text(
                                          '취소',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.rootDelegate.toNamed(Routes.HOME2);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        _sizedBoxWidget(30),
                      ],
                    ),
                  ],
                )
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }

  Widget _mainTitleWidget() {
    return Text(
      '스터디모임 보고서 작성',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _subTitleWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _imageUploadWidget() {
    return InkWell(
      child: Obx(() {
        return isImagePicked.value == true ?
        Container(
          height: 17,
          width: 113,
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                  width: 1,
                  color: Colors.blue
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(3)
              )
          ),
          child: Center(
            child: Text(
              '사진 촬영/이미지 업로드',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
            ),
          ),
        ) :
        Container(
          height: 17,
          width: 113,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Colors.blue
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(3)
              )
          ),
          child: Center(
            child: Text(
              '사진 촬영/이미지 업로드',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 8,
              ),
            ),
          ),
        );
      }
      ),
      onTap: () async {
        // pickedImage = await imagePickerService.pickImg();
        // if (pickedImage != null) {
        //   isImagePicked.value = true ;
        // }
      },
    );
  }

  Widget _divideWidget() {
    return Container(
      height: 1,
      color: Colors.black,
    );
  }

  Widget _createCodeWidget() {
    return InkWell(
      child: Container(
        height: 17,
        width: 48,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
                Radius.circular(3)
            )
        ),
        child: Center(
          child: Text(
            '코드 생성',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
          ),
        ),
      ),
      onTap: () {
        print("Clicked");
      },
    );
  }

  Widget _participantsWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CheckboxListTileFormField(
            title: Text('1'),
            onSaved: (bool? value) {
              print(value);
            },
            validator: (bool? value) {
              if (value!) {
                print("ListTile Checked :)");
              } else {
                print("ListTile Not Checked :)");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _startTimeInputWidget() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
          hintText: '시작시간을 입력하세요.',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
    );
  }

  Widget _endTimeInputWidget() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
          hintText: '끝시간을 입력하세요.',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
    );
  }

  Widget _studyTitleInputWidget() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
          hintText: '제목을 입력하세요.',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
    );
  }

  Widget _contentsInputWidget() {
    return Expanded(
      child: TextFormField(
        maxLines: 50,
        decoration: InputDecoration(
            hintText: '내용을 입력하세요.',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: Colors.black)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: Colors.black)
            )
        ),
      ),
    );
  }

  Widget _sizedBoxWidget(int value) {
    return SizedBox(
      height: value.h,
    );
  }
}