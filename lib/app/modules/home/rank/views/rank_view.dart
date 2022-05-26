import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/rank_controller.dart';

class RankView extends GetView<RankController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
          child: Container (
              child : Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/handong_logo.png')),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.rootDelegate.toNamed(Routes.HOME);
                          },
                          child: Text(
                            'HISTUDY',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.HOME2);
                            },
                            child: Text("HOME")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.GROUP_INFO);
                            },
                            child: Text("TEAM")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.QUESTION);
                            },
                            child: Text("Q&A")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.ANNOUNCE);
                            },
                            child: Text("ANNOUNCEMENT")),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.RANK);
                            },
                            child: Text("RANK")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.GUIDELINE);
                            },
                            child: Text("GUIDELINE")),
                        ElevatedButton(onPressed: () {
                          Get.rootDelegate.toNamed(Routes.MY_PAGE);
                        }, child: Text('MY PAGE'))
                      ],
                    ),
                  ]),
                ),
                Flexible(
                  child: Column(
                      children:[
                        Divider(
                          thickness: 0.11,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 280.w,
                              ),
                              Expanded(child:Text('  그룹 번호')),
                              Expanded(child: Text('  보고서 수')),
                              Expanded(child: Text('  최신 보고서 날짜')),
                              Expanded(child: Text('   누적 공부 시간')),
                              Expanded(child: Text(' ')),
                            ]
                        ) ,
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                          height: 10,
                        ),
                        Flexible(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('Group').orderBy('time',descending: true).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          children:[
                                            ListTile(
                                              title: Row(
                                                  children: <Widget>[
                                                    Expanded(child: Text('${index+1}')),
                                                    Expanded(child: Text('Group ${documentSnapshot.id}')),
                                                    Expanded(child: Text(documentSnapshot['count'].toString())),
                                                    Expanded(child: Text(documentSnapshot['recRegDate'].toString())),
                                                    Expanded(child: Text(documentSnapshot['time'].toString())),
                                                  ]
                                              ),

                                            ),
                                          ]
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ]),
                )

              ])

          )
      ),
    );
  }
}