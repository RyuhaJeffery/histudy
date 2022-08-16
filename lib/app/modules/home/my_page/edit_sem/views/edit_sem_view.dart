import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/edit_sem_controller.dart';

class EditSemView extends StatefulWidget {
  const EditSemView({Key? key}) : super(key: key);

  @override
  _EditSemViewState createState() => _EditSemViewState();
}

class _EditSemViewState extends State<EditSemView> {
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _semController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference yearCollection =
        FirebaseFirestore.instance.collection('year');
    late String curId;
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
              '학기 관리',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Colors.black87),
            ),
          ]),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 150,
            child: ElevatedButton(
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
                      title: Text("새로운 연도와 학기를 입력하세요"),
                      content: Column(
                        children: [
                          TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _yearController,
                            decoration: const InputDecoration(
                              labelText: '추가할 연도',
                            ),
                          ),
                          TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _semController,
                            decoration: const InputDecoration(
                              labelText: '추가할 학기',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              yearCollection.add({
                                'year': int.parse(_yearController.text),
                                'semester': int.parse(_semController.text),
                                'thisSem': false,
                              });

                              Get.back();
                            },
                            child: Text("예"))
                      ],
                    ),
                  );
                },
                child: Text('새로운 학기 추가')),
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
                        '  연도',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Expanded(
                          child: Text(
                        '  학기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Expanded(
                          child: Text(
                        '  해당 학기 유무',
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
                    stream: yearCollection
                        .orderBy('year', descending: true)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            if (documentSnapshot['thisSem'] == true) {
                              curId = documentSnapshot.id;
                            }
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(children: [
                                ListTile(
                                  // title: Text(documentSnapshot['name']),
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200.w,
                                        ),
                                        Expanded(
                                            child: Text(documentSnapshot['year']
                                                .toString())),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                            child: Text(
                                                documentSnapshot['semester']
                                                    .toString())),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                            child: documentSnapshot['thisSem']
                                                ? Text("현재 학기")
                                                : Text("  ")),
                                      ]),
                                  // documentSnapshot['isAdmin'].toString() ?

                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Get.dialog(
                                              AlertDialog(
                                                title: Text(
                                                    "시스템을 해당학기로 변경하시겠습니까?"),
                                                content: Text(
                                                    "학생들의 그룹 정보도 초기화 됩니다."),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        yearCollection
                                                            .doc(curId)
                                                            .update({
                                                          'thisSem': false
                                                        });
                                                        yearCollection
                                                            .doc(
                                                                documentSnapshot
                                                                    .id)
                                                            .update({
                                                          'thisSem': true
                                                        });
                                                        List<String>
                                                            profileList =
                                                            new List.generate(0,
                                                                (index) => "");
                                                        final QuerySnapshot
                                                            profileResult =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Profile')
                                                                .where(
                                                                    "classRegister",
                                                                    isEqualTo:
                                                                        true)
                                                                .get();
                                                        final profileLen =
                                                            profileResult
                                                                .docs.length;
                                                        final List<
                                                                DocumentSnapshot>
                                                            profileDocs =
                                                            profileResult.docs;
                                                        profileDocs
                                                            .forEach((profile) {
                                                          profileList
                                                              .add(profile.id);
                                                        });

                                                        for (int i = 0;
                                                            i < profileLen;
                                                            i++) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Profile")
                                                              .doc(profileList[
                                                                  i])
                                                              .update({
                                                            "classRegister":
                                                                false,
                                                            "group": 0
                                                          });
                                                        }
                                                        Get.snackbar(
                                                          "시스템 연도 수정 완료",
                                                          "새로 고침 후 다시 시작하세요",
                                                          backgroundColor:
                                                              Color(0xff04589C),
                                                          colorText:
                                                              Color(0xffF0F0F0),
                                                        );
                                                        Get.rootDelegate
                                                            .toNamed(
                                                                Routes.HOME);
                                                      },
                                                      child: Text("예"))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
