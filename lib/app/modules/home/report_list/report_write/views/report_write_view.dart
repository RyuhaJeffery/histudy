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
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/report_write_controller.dart';


// Report 추가 할 때, 총 시간 값을 Group field로 만들어 duration을 더해주기

class ReportWriteView extends GetView<ReportWriteController> {
<<<<<<< HEAD
  // var imagePickerService = ImagePickerService();
=======
  //var imagePickerService = ImagePickerService();
>>>>>>> e325832e6d0cc6bd27ebf27d3ea84298102a4ea8
  File? pickedImage;
  RxBool isImagePicked = false.obs;

  html.File? imageFile ;
  // PickedFile? pickedFile ;

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
        future: UserRepositroy.getUser(AuthService.to.auth.value.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileModel profile = snapshot.data!;
            return Scaffold(
                backgroundColor: Color(0xffFDFFFE),
                body: ListView(
                  children: [
                    Column(
                      children: [
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
                              _imageUploadWidget(profile),
                              _sizedBoxWidget(16),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _createCodeWidget(),
                              _sizedBoxWidget(16),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('참여 멤버'),
                              _participantsWidget(profile),
                              _divideWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 시작 시간 입력'),
                              _sizedBoxWidget(16),
                              _startTimeInputWidget(),
                              _sizedBoxWidget(16),
                              _subTitleWidget('스터디 시간 입력(분단위)'),
                              _sizedBoxWidget(16),
                              _durationInputWidget(),
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
                              _bottomButtons(profile),
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
            return Container(height : 400.h, width: 400.w ,child: Center(child: CircularProgressIndicator()));
          }
        }
    );
  }

  Widget _mainTitleWidget() {
    return Text(
      '스터디모임 보고서 작성',
      style: TextStyle(
          fontSize: 20.sp,
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

  Widget _imageUploadWidget(ProfileModel profile) {
    return InkWell(
      child: Obx(() {
        return isImagePicked.value == true ?
        Container(
          height: 17.h,
          width: 113.w,
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                  width: 1,
                  color: Colors.blue
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(3.r)
              )
          ),
          child: Center(
            child: Text(
              '사진 촬영/이미지 업로드',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8.sp,
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
<<<<<<< HEAD
        // pickedFile = await ImagePicker().getImage(
        //   source: ImageSource.gallery,
        // );
        // imageFile = await ImagePickerWeb.getImageAsFile();
        // print(imageFile);
        // pickedImage = await imagePickerService.pickImg();
        // if (pickedImage != null) {
        //   isImagePicked.value = true ;
        //   print(pickedImage);
        // }
        // print(pickedImage);
=======
        //pickedImage = await imagePickerService.pickImg();
        if (pickedImage != null) {
          isImagePicked.value = true ;
        }
>>>>>>> e325832e6d0cc6bd27ebf27d3ea84298102a4ea8
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
        height: 17.h,
        width: 48.w,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
                Radius.circular(3.r)
            )
        ),
        child: Center(
          child: Text(
            '코드 생성',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.sp,
            ),
          ),
        ),
      ),
      onTap: () {
        code.value = getRandomString(5);
        Get.dialog(
            AlertDialog(
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
                height: 200.h,
                width: 300.w,
                child: Center(
                  child: Text(
                    code.toString(),
                    style: TextStyle(
                        fontSize: 64.sp
                    ),
                  ),
                ),
              ),
            ));
        makingCodeTime = DateTime.now();
        print(makingCodeTime);
      },
    ) ;
  }

  Widget _participantsWidget(ProfileModel profileModel) {

    return FutureBuilder<GroupModel?>(
      future: GroupRepository.getGroup(profileModel.group!.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GroupModel groupModel = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: groupModel.members!.length,
                itemBuilder: (BuildContext context, int index) {
                  List<RxBool> _isCheckedList = List<RxBool>.filled(groupModel.members!.length, false.obs, growable: true);
                  return Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                            value: _isCheckedList[index].value,
                            onChanged: (value) {
                              _isCheckedList[index].value == true ? _isCheckedList[index].value = false : _isCheckedList[index].value = true ;
                              value == true ? finalCheckedMembers.add(groupModel.members![index]) : finalCheckedMembers.removeAt(index);
                              print(finalCheckedMembers);
                            }
                          ),
                          FutureBuilder<ProfileModel?>(
                            future: UserRepositroy.getUser(groupModel.members![index].toString()),
                            builder: (context, profileSnapshot) {
                              if (profileSnapshot.hasData) {
                                ProfileModel profileModelInGroup = profileSnapshot.data!;
                                return Text(profileModelInGroup.name.toString());
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      );
                    }
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
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
      }
    );
    // return TextFormField(
    //   maxLines: 1,
    //   decoration: InputDecoration(
    //       hintText: '시작시간을 입력하세요.',
    //       border: OutlineInputBorder(
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(8),
    //           ),
    //           borderSide: BorderSide(color: Colors.black)
    //       ),
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(8),
    //           ),
    //           borderSide: BorderSide(color: Colors.black)
    //       )
    //   ),
    // );
  }

  Widget _durationInputWidget() {
    return TextFormField(
      maxLines: 1,
      initialValue: duration,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: '수행 시간을 입력하세요.',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: Colors.black)
          )
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
      onChanged: (value) {
        title = value ;
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                borderSide: BorderSide(color: Colors.black)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                borderSide: BorderSide(color: Colors.black)
            )
        ),
        onChanged: (value) {
          contents = value ;
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
        InkWell(
          child: Container(
            height: 27.h,
            width: 68.w,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                    Radius.circular(3.r)
                )
            ),
            child: Center(
              child: Text(
                '작성',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          onTap: () {
            if (DateTime.now().difference(makingCodeTime).inMinutes > 10) {
              Get.snackbar('Regenerate code', 'It has been more than 10 minutes since code generation. Please recreate the code.');
            } else {
              if (finalCheckedMembers.isEmpty || startingTime.isEmpty || duration.isEmpty || title.isEmpty || contents.isEmpty) {
                Get.snackbar('Retry', 'You have not entered anything');
              } else {
                ReportRepository.uploadReport(profileModel.uid.toString(), code.toString(), makingCodeTime, DateTime.now(), duration, profileModel.group.toString(), "", finalCheckedMembers, startingTime.toString(), contents, title);
                Get.rootDelegate.toNamed(Routes.HOME2);
              }
            }
          },
        ),
        SizedBox(
          width: 16.w,
        ),
        InkWell(
          child: Container(
            height: 27.h,
            width: 68.w,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                    Radius.circular(3.r)
                )
            ),
            child: Center(
              child: Text(
                '취소',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          onTap: () {
            // ImagePickerService().uploadFile(profileModel.uid.toString(), imageFile!);
            // Get.rootDelegate.toNamed(Routes.HOME2);
            // ImagePickerService().uploadFile(profileModel.uid.toString(), imageFile!);
            // ImagePickerService().uploadImageFile(imageFile!, profileModel.uid.toString());
            // ImagePickerService().uploadImageToStorage(pickedFile);
          },
        ),
      ],
    );
  }

  final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}