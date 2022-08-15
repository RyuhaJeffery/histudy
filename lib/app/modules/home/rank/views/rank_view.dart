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
    String? semId = Get.rootDelegate.parameters['semId'];
    return Scaffold(
        backgroundColor: Color(0xffFDFFFE),
        body: Center(
          child: Container(
            child: Column(children: [
              topBar(Get.rootDelegate.parameters["semId"]),
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
                height: 30,
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
                    child: Column(children: [
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
                        height: 10,
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
                                                    child:
                                                        Text('${index + 1}')),
                                                Expanded(
                                                    child: Text(
                                                        'Group ${documentSnapshot.id}')),
                                                Expanded(
                                                    child: Text(
                                                        documentSnapshot[
                                                                'meeting']
                                                            .toString())),
                                                // Expanded(child: Text(documentSnapshot['recRegDate'].toString())),
                                                Expanded(
                                                    child: Text(
                                                        documentSnapshot['time']
                                                            .toString())),
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
                    ])),
                // Expanded(child: Text(' ')),
              ),
            ]),
          ),
        ));
  }
}
