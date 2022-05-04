import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../controllers/question_write_controller.dart';

class QuestionWriteView extends GetView<QuestionWriteController> {
  final List<String> subjectItems = [
    '객체지향 설계 패턴',
    '소프트웨어 공학',
    '데이타구조',
    '운영체제'
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: Colors.blue,
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Q&A',
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
                      '사진 올리기 (* 파일명에 한글이 들어가면 오류가 날 수 있음)',
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
                          height: 17,
                          width: 113,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(3)
                            )
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          child: Container(
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
                          ),
                          onTap: () {
                            print("Clicked");
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
                    Row(
                      children: [
                        Text(
                          '제목',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 25,
                          width: 670,
                          child: TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left:8 ,bottom: 4),
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
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          '과목',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 25,
                          width: 200,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              '과목을 선택하여주세요.',
                              style: TextStyle(fontSize: 10),
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                            ),
                            items: subjectItems
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                          ),
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
                      'Q&A 내용',
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
                            Get.rootDelegate.toNamed(Routes.QUESTION);
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
