import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/rank_controller.dart';

class RankView extends GetView<RankController> {
  @override
  Widget build(BuildContext context) {
    var reponsiveWidth = MediaQuery.of(context).size.width;
    String? semId = Get.rootDelegate.parameters['semId'];
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                topBar(Get.rootDelegate.parameters["semId"], context),
                SizedBox(
                  height: 30.h,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '랭킹',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87),
                  ),
                ]),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 350.h,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                '    NO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              Expanded(
                                  child: Text(
                                '  그룹 번호',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              Expanded(
                                  child: Text(
                                '보고서 수',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              Expanded(
                                  child: Text(
                                '누적 공부 시간',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ]),
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                          height: 10.h,
                        ),
                        Flexible(
                          child: semId != null
                              ? StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(semId)
                                      .doc(semId)
                                      .collection('Group')
                                      .orderBy('time', descending: true)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    if (streamSnapshot.hasData) {
                                      return ListView.builder(
                                        itemCount:
                                            streamSnapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[index];
                                          return Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(children: [
                                              ListTile(
                                                title: Row(children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    '    ${index + 1}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )),
                                                  Expanded(
                                                      child: Text(
                                                    '  Group ${documentSnapshot.id}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )),
                                                  Expanded(
                                                      child: Text(
                                                    '      ${documentSnapshot['meeting'].toString()}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )),
                                                  Expanded(
                                                      child: Text(
                                                    "  ${documentSnapshot['time'].toString()}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )),
                                                ]),
                                              ),
                                            ]),
                                          );
                                        },
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                )
                              : Container(),
                        ),
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                semId != null
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(semId)
                            .doc(semId)
                            .collection('Group')
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            var itemLength = streamSnapshot.data!.docs.length;
                            return Container(
                              height: reponsiveWidth > 1400
                                  ? (itemLength / 8).h * 250
                                  : reponsiveWidth > 1100
                                      ? (itemLength / 8).h * 200
                                      : reponsiveWidth > 780
                                          ? (itemLength / 8).h * 140
                                          : reponsiveWidth > 562
                                              ? (itemLength / 6).h * 140
                                              : (itemLength / 4).h * 140,
                              child: GridView.builder(
                                itemCount: itemLength,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: reponsiveWidth > 780
                                      ? 8
                                      : reponsiveWidth > 562
                                          ? 6
                                          : 4, //1 개의 행에 보여줄 item 개수
                                  childAspectRatio:
                                      1 / 1, //item 의 가로 1, 세로 2 의 비율
                                  mainAxisSpacing: 5, //수평 Padding
                                  crossAxisSpacing: 5, //수직 Padding
                                ),
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  if (documentSnapshot['imageUrl'] == "") {
                                    return Container();
                                  } else {
                                    return Container(
                                      child: Image.network(
                                        documentSnapshot['imageUrl'],
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
