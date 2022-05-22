import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'package:get/get.dart';
import 'package:histudy/app/modules/home/my_page/views/my_page_setting.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/my_page_controller.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class MyPageView extends GetView<MyPageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;
  String name = "";
  String phone = "";
  String studentNumber = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('Profile')
        .doc(userProfile!.uid)
        .snapshots();
  //  print(userProfile!.uid);
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
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
                          ElevatedButton(
                              onPressed: () {}, child: Text('LOGOUT'))
                        ],
                      ),
                    ]),
              ),
              Center(
                  child: Container(
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      width: 450,
                      height: 650,
                      padding: EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("마이 페이지",  style: TextStyle(fontSize: 15,fontWeight:FontWeight.w300)),
                                SizedBox(
                                  width: 180,
                                ),
                                IconButton(
                                  onPressed: () {
                                    //controller.changed_enabled();
print("name"+name);
                                   Get.to(MyPageSettingView(),arguments:{'name': name,'studentNumber':studentNumber,'email': email,'phone':phone} );
                                  },

                                  icon: Icon(
                                    PhosphorIcons.pencil, // Pencil Icon
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _userStream,
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    final getdata = snapshot.data;
                                    if (snapshot.hasData) {
                                      name = '${getdata?["name"]}';
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "이름",
                                            style: TextStyle(fontSize: 12,color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 250,
                                            //margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xFFECEFF1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              '${getdata?["name"]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(width: 30),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _userStream,
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    final getdata = snapshot.data;
                                    if (snapshot.hasData) {
                                     studentNumber = '${getdata?["studentNumber"]}';

                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "학번",
                                            style: TextStyle(fontSize: 12,color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 250,
                                            //margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xFFECEFF1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              '${getdata?["studentNumber"]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _userStream,
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    final getdata = snapshot.data;
                                    if (snapshot.hasData) {
                                   email  = '${getdata?["email"]}';
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "이메일",
                                            style: TextStyle(fontSize: 12,color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 250,
                                            //margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xFFECEFF1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              '${getdata?["email"]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(width: 30),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _userStream,
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    final getdata = snapshot.data;
                                    if (snapshot.hasData) {
                                      phone = '${getdata?["phone"]}';
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "전화 번호",
                                            style: TextStyle(fontSize: 12,color: Colors.black54),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 250,
                                            //margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xFFECEFF1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              '${getdata?["phone"]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),


                            SizedBox(height: 30),


                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "수강중인 과목 1",
                                        style: TextStyle(fontSize: 12,color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 530,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["myClasses"][1]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "수강중인 과목 2",
                                        style: TextStyle(fontSize: 12,color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 520,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["myClasses"][2]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "수강중인 과목 3",
                                        style: TextStyle(fontSize: 12,color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 520,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["myClasses"][3]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "수강중인 과목 4",
                                        style: TextStyle(fontSize: 12,color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 520,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["myClasses"][4]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),


                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}




