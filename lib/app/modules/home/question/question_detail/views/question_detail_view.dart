import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/question_detail_controller.dart';

class QuestionDetailView extends GetView<QuestionDetailController> {
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
                          _titleWidget('제목'),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Agile Development에 대해서 잘 모르겠습니다!',
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
                          _titleWidget('작성자'),
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
                      _dividerWidget(),
                      _titleWidget('내용'),
                      Text(
                        'Agile Development에 대해서 공부하고 있는데, 잘 모르겠어요 알려주시면 감사하겠습니다!'
                      ),
                      _dividerWidget(),
                      _titleWidget('댓글'),
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

  Widget _titleWidget(String title) {
    return Text(
        title,
        style: TextStyle(
            fontSize: 20,
            color: Colors.black
        ),
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
