import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Column(
        children: [
          topBar(Get.rootDelegate.parameters["semId"]),

          SizedBox(
            height: 30.h,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Q&A',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Colors.black87),
            ),
          ]),
          SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '과목별 Q&A는 추후 업데이트 예정',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87),
            ),
          ]),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: 500,
          //     ),
          //     SizedBox(
          //       width: 110,
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             primary: Color(0xff04589C),
          //             side: BorderSide(width: 1),
          //             shape: RoundedRectangleBorder(
          //               //to set border radius to button
          //                 borderRadius: BorderRadius.circular(5)),
          //           ),
          //           onPressed: () {
          //             Get.rootDelegate.toNamed(Routes.QUESTION_WRITE);
          //           },
          //           child: const Text('질문 작성')),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
          //   child: Container(
          //     child:Column(children: [
          //       Divider(
          //         thickness: 0.1,
          //         color: Colors.black,
          //         height: 10,
          //       ),
          //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

          //         Expanded(
          //             child: Text(
          //               '  NO',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             )),
          //         Expanded(
          //             child: Text(
          //               '  제목',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             )),
          //         Expanded(
          //             child: Text(
          //               '  작성자',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             )),
          //         Expanded(
          //             child: Text(
          //               '  과목',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             )),

          //       ]),
          //       Divider(
          //         thickness: 0.1,
          //         color: Colors.black,
          //         height: 10,
          //       ),
          //     ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
