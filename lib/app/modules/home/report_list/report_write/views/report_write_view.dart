import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/services/image_picker_service.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/report_write_controller.dart';

class ReportWriteView extends GetView<ReportWriteController> {
  var imagePickerService = ImagePickerService();
  File? pickedImage;
  RxBool isImagePicked = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: ListView(
        children: [
          Column(
            children: [
              topBar(),
              SizedBox(
                height: 22,
              ),
              Text(
                '스터디모임 보고서 작성',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                padding: EdgeInsets.all(30),
                height: 1040,
                width: 774,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증샷 올리기 (* 파일명에 한글이 들어가면 오류가 날 수 있음)',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
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
                            pickedImage = await imagePickerService.pickImg();
                            if (pickedImage != null) {
                              isImagePicked.value = true ;
                            }
                          },
                        )
                      ],
                    ),
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
                    InkWell(
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
                    ),
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
                    Text(
                      '참여 멤버',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black
                            )
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '류운선(yws2121@naver.com)',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '류운선(yws2121@naver.com)',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '류운선(yws2121@naver.com)',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '류운선(yws2121@naver.com)',
                        )
                      ],
                    ),
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
                    Text(
                      '스터디 시작 시간 입력',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '스터디 시간 입력(분단위)',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                    ),
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
                    Text(
                      '스터디 제목',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '스터디 내용',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      )
    );
  }
}
