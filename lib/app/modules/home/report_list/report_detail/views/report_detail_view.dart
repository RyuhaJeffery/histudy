import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_detail_controller.dart';

class ReportDetailView extends GetView<ReportDetailController> {
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
                      Row(
                        children: [
                          Text(
                            '제목',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '5주차 OS 복습',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
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
                            '참여 멤버',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                '류운선(yws2121@naver.com)',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '류운선(yws2121@naver.com)',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '류운선(yws2121@naver.com)',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            '스터디 시간',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '2022/03/15 19:00 ~ 21:00 (120분)',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            ),
                          ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '스터디 내용',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            children: [
                              Text(
                                '우리 복습 너무 유익하고 재미있었다.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '우리 복습 너무 유익하고 재미있었다.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '우리 복습 너무 유익하고 재미있었다.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '우리 복습 너무 유익하고 재미있었다.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이미지',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 500,
                            width: 500,
                            color: Colors.teal,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
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
                                '나가기',
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
        )
    );
  }
}
