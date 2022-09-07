import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../controllers/registered_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisteredView extends StatefulWidget {
  const RegisteredView({Key? key}) : super(key: key);

  @override
  State<RegisteredView> createState() => _RegisteredViewState();
}

class _RegisteredViewState extends State<RegisteredView> {
  //var firebaseUser = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _firebaseAuth =
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    String? semId = Get.rootDelegate.parameters['semId'];
    final CollectionReference _registeredClass = FirebaseFirestore.instance
        .collection('Class')
        .doc(semId)
        .collection('subClass');

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
              '신청한 과목 코드',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff04589C),
              side: BorderSide(width: 1),
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text("정말 Histudy를 다시 신청하시겠습니까?"),
                  content: Text("기존의 신청 정보는 삭제 됩니다."),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        if (semId != null) {
                          final CollectionReference _friendFire =
                              FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(firebaseUser?.uid)
                                  .collection(semId);
                          List<String> friendList =
                              List<String>.empty(growable: true);
                          await _friendFire.get().then((QuerySnapshot qs) {
                            qs.docs.forEach((doc) {
                              friendList.add(doc.id);
                            });
                          });
                          for (int i = 0; i < friendList.length; i++) {
                            await _friendFire.doc(friendList[i]).delete();
                          }
                          await Get.rootDelegate.toNamed(
                            Routes.REGISTER,
                            arguments: true,
                            parameters: {"semId": semId},
                          );
                        }
                      },
                      child: Text("다시 신청하겠습니다."),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("아니요"),
                    ),
                  ],
                ),
              );
            },
            child: Text('Histudy 다시 신청하기'),
          ),
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
                      SizedBox(
                        width: 230.w,
                      ),
                      Expanded(
                          child: Text(
                        '              수업명',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Expanded(
                          child: Text(
                        '             교수님',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Expanded(
                          child: Text(
                        '                       과목코드',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Expanded(
                          child: Text(
                        '                  가중치 점수',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      SizedBox(
                        width: 180.w,
                      ),
                    ]),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                  height: 10,
                ),
                Flexible(
                  child: StreamBuilder(
                    stream: _registeredClass
                        .orderBy('class', descending: true)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        int subIndex = 0;
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot ds =
                                streamSnapshot.data!.docs[index];
                            return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('Profile')
                                  .doc(user!.uid)
                                  .collection('classScore')
                                  .doc(semId)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot1) {
                                if (snapshot1.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> subDs = snapshot1.data!
                                      .data() as Map<String, dynamic>;

                                  if (subDs["${ds.id}"] > 0) {
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                    child: Text(
                                                        '${subIndex++ + 1}')),
                                                Expanded(
                                                    child: Text(ds['class'])),
                                                Expanded(
                                                    child:
                                                        Text(ds['professor'])),
                                                Expanded(
                                                    child: Text(ds['code'])),
                                                Expanded(
                                                    child: Text(
                                                        subDs["${ds.id}"]
                                                            .toString())),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                                return Container();
                              },
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
            ),
          )
        ],
      ),
    );
  }
}
