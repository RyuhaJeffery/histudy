import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/models/classScore_model.dart';
import 'package:histudy/app/routes/app_pages.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';
import '../../../../../firestore_search/firestore_search.dart';
import '../../../../models/class_model.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    String? semId = Get.rootDelegate.parameters['semId'];

    // final classInfo =
    late int classlength;
    var classScoreList = List<ClassScore>.empty(growable: true);
    List<TextEditingController> _scoreController =
        new List.generate(0, (index) => TextEditingController());

    FirebaseFirestore.instance
        .collection("Class")
        .doc(Get.rootDelegate.parameters['semId'])
        .collection("subClass")
        .get()
        .then((QuerySnapshot qs) {
      // List<ClassScore>.generate(qs.docs.length, (index) {});
      classlength = qs.docs.length;

      qs.docs.forEach((docs) {
        ClassScore temp = new ClassScore(classId: docs.id, score: 0);
        classScoreList.add(temp);
        _scoreController.add(TextEditingController());
      });
      print(classScoreList[0].getClassScore().classId);
    });
    return Scaffold(
      body: Column(
        children: [
          topBar(semId),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Histudy 등록",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.black87),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "<Histudy 신청방법>",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "과목별로 0~10까지 가중치를 입력할 수 있습니다. 입력된 가중치는 Histudy 알고리즘에 의해서 다른 학우님과 자동 매칭됩니다.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "히즈넷 상의 과목을 검색하시면 과목이 나타납니다. 과목과 교수님을 확인하여 왼쪽에 가중치를 입력하세요.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "첫 띄어쓰기까지 입력해야지 과목이 나타납니다.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "입력된 가중치가 높아질 수록 해당 과목에 가중치가 높은 학우님과 매칭될 가능성이 높아집니다.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "입력하지 않은 과목은 0의 가중치가 들어갑니다.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black87),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            width: 1000.w,
            height: 350.h,
            // padding: EdgeInsets.all(30),
            child: FirestoreSearchScaffold(
              scaffoldBody: Center(),
              firestoreCollectionName: 'Class', //Class/${semId}/
              firestoreDocsName: semId,
              firestoreSubCollectionName: 'subClass',
              searchBy: 'class',
              appBarBackgroundColor: Color(0xff04589C),
              dataListFromSnapshot: ClassModel().dataListFromSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<ClassModel>? dataList = snapshot.data;
                  if (dataList!.isEmpty) {
                    return const Center(
                      child: Text('No a Returned'),
                    );
                  }
                  return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      _scoreController[index].text = '0';
                      print(dataList[index].classId);
                      print("수정 전 text데이터");
                      print(_scoreController[index].text);

                      for (int i = 0; i < classlength; i++) {
                        if (dataList[index].classId ==
                            classScoreList[i].getClassScore().classId) {
                          _scoreController[index].text = classScoreList[i]
                              .getClassScore()
                              .score
                              .toString();
                        }
                      }
                      print("수정 후 text데이터");
                      print(_scoreController[index].text);
                      final ClassModel data = dataList[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            title: Container(
                              width: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data.className}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "과목코드: ${data.code} / ${data.professor} 교수님",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: 200,
                              child: TextFormField(
                                //     initialValue: Get.arguments,
                                controller: _scoreController[index],
                                decoration: InputDecoration(
                                  // hintText: name,

                                  labelText: '가중치 입력',
                                  labelStyle: TextStyle(fontSize: 12),
                                  hintText: "0~10",

                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,

                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFECEFF1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter score';
                                  } else if (int.tryParse(value) != null) {
                                    return '숫자만 입력해주세요. ';
                                  } else if (int.parse(value) < 0) {
                                    return '가중치는 0보다 커야합니다. ';
                                  } else if (int.parse(value) > 10) {
                                    return '가중치는 10보다 작아야합니다. ';
                                  }
                                },
                                onChanged: (String? value) {
                                  if (int.parse(value!) < 0) {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text("가중치는 0보다 커야합니다."),
                                      ),
                                    );
                                  } else if (int.parse(value) > 10) {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text("가중치는 10보다 작아야합니다."),
                                      ),
                                    );
                                  }

                                  if (int.tryParse(value) != null) {
                                    for (int i = 0; i < classlength; i++) {
                                      if (dataList[index].classId ==
                                          classScoreList[i]
                                              .getClassScore()
                                              .classId) {
                                        classScoreList[i].setScore(int.parse(
                                            _scoreController[index].text));
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                        ],
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Resultsssss Returned'),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD1C4E9),
                  spreadRadius: 8,
                  blurRadius: 20,
                ),
              ],
            ),
            child: ElevatedButton(
              child: Container(
                width: 300,
                height: 35,
                child: Center(
                  child: Text("제 출"),
                ),
              ),
              onPressed: () async {
                Get.dialog(
                  AlertDialog(
                    title: Text("이번학기 Histudy를 신청하시겠습니까?"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("Profile")
                                .doc(firebaseUser!.uid)
                                .collection("classScore")
                                .doc(Get.rootDelegate.parameters['semId'])
                                .set({});
                            for (int i = 0; i < classlength; i++) {
                              await FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(firebaseUser!.uid)
                                  .collection("classScore")
                                  .doc(Get.rootDelegate.parameters['semId'])
                                  .update({
                                classScoreList[i].getClassScore().classId:
                                    classScoreList[i].getClassScore().score,
                              });
                            }
                            FirebaseFirestore.instance
                                .collection("Profile")
                                .doc(firebaseUser!.uid)
                                .update({
                              "classRegister": true,
                            });
                            String? semId =
                                Get.rootDelegate.parameters['semId'];
                            if (semId != null) {
                              Get.rootDelegate.toNamed(
                                Routes.MY_PAGE,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
                            }
                          },
                          child: Text("예"))
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class RegisterView extends GetView<RegisterController> {
//   final classInfo = FirebaseFirestore.instance
//       .collection("Class")
//       .doc(Get.rootDelegate.parameters['semId'])
//       .collection("subClass")
//       .orderBy("class");
//   User? currentUser;
//   var firebaseUser = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     // late int classNum;
//     // classInfo.snapshots().length.then((value) => classNum = value);

//     List<TextEditingController> _scoreController =
//         new List.generate(0, (index) => TextEditingController());

//     List<String> _classCodeList = new List.generate(0, (index) => "");
//     final _formkey = GlobalKey<FormState>();
//     int? length;
//     String? semId = Get.rootDelegate.parameters['semId'];
//     print(semId);
//     //Map을 하나 만들어서 하기

//     return Scaffold(
//       body: Container(
//         height: 1000.h,
//         child: Column(
//           children: [
//             topBar(Get.rootDelegate.parameters["semId"]),
//             SizedBox(height: 30.h),
//             Center(
//               child: Container(
//                 width: 800,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   width: 450,
//                   height: 700,
//                   padding: EdgeInsets.all(30),
//                   child: StreamBuilder(
//                     stream: classInfo.snapshots(),
//                     builder:
//                         (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//                       length = streamSnapshot.data!.docs.length;
//                       if (streamSnapshot.hasData) {
//                         return ListView.builder(
//                             itemCount: length,
//                             itemBuilder: (context, index) {
//                               _scoreController.add(TextEditingController());
//                               _scoreController[index].text = "0";
//                               final DocumentSnapshot documentSnapshot =
//                                   streamSnapshot.data!.docs[index];
//                               _classCodeList.add(documentSnapshot.id);
//                               // _scoreController[index].text = '0';
//                               return Container(
//                                 margin: EdgeInsets.all(10),
//                                 child: Column(
//                                   children: [
//                                     ListTile(
//                                       leading: Text(
//                                         "${index + 1}",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       title: Container(
//                                         width: 20,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               documentSnapshot['class'],
//                                               style: TextStyle(fontSize: 15),
//                                             ),
//                                             Text(
//                                               "과목코드: ${documentSnapshot['code']} / ${documentSnapshot['professor']} 교수님",
//                                               style: TextStyle(fontSize: 15),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       trailing: Container(
//                                         width: 200,
//                                         child: TextFormField(
//                                           //     initialValue: Get.arguments,
//                                           controller: _scoreController[index],
//                                           decoration: InputDecoration(
//                                             // hintText: name,

//                                             labelText: '가중치 입력',
//                                             labelStyle: TextStyle(fontSize: 12),
//                                             hintText: "0~10",

//                                             hintStyle: TextStyle(
//                                                 fontSize: 13,
//                                                 color: Colors.black54),
//                                             filled: true,
//                                             fillColor: Colors.white,

//                                             contentPadding:
//                                                 EdgeInsets.only(left: 15),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.black38),
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Color(0xFFECEFF1)),
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                             ),
//                                           ),
//                                           validator: (String? value) {
//                                             if (value!.isEmpty) {
//                                               return 'Please enter score';
//                                             } else if (int.parse(value) < 0) {
//                                               return '가중치는 0보다 커야합니다. ';
//                                             } else if (int.parse(value) > 10) {
//                                               return '가중치는 10보다 작아야합니다. ';
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Divider(
//                                       color: Colors.black26,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                       }

//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.h),
//             Container(
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFFD1C4E9),
//                     spreadRadius: 8,
//                     blurRadius: 20,
//                   ),
//                 ],
//               ),
//               child: ElevatedButton(
//                 child: Container(
//                   width: 300,
//                   height: 35,
//                   child: Center(
//                     child: Text("제 출"),
//                   ),
//                 ),
//                 onPressed: () async {
//                   var classScore = List.generate(0, (index) => 0);

//                   for (int i = 0; i < length!; i++) {
//                     classScore.add(int.parse(_scoreController[i].text));
//                   }

//                   // for (int i = 0; i < length!; i++) {
//                   //   print(classScore[i]);
//                   // }

//                   await FirebaseFirestore.instance
//                       .collection("Profile")
//                       .doc(firebaseUser!.uid)
//                       .collection("classScore")
//                       .doc(Get.rootDelegate.parameters['semId'])
//                       .set({});
//                   for (int i = 0; i < length; i++) {
//                     await FirebaseFirestore.instance
//                         .collection("Profile")
//                         .doc(firebaseUser!.uid)
//                         .collection("classScore")
//                         .doc(Get.rootDelegate.parameters['semId'])
//                         .update({
//                       _classCodeList[i].toString(): classScore[i],
//                     });
//                   }
//                   FirebaseFirestore.instance
//                       .collection("Profile")
//                       .doc(firebaseUser!.uid)
//                       .update({
//                     "classRegister": true,
//                   });
//                   String? semId = Get.rootDelegate.parameters['semId'];
//                   if (semId != null) {
//                     Get.rootDelegate.toNamed(
//                       Routes.MY_PAGE,
//                       arguments: true,
//                       parameters: {'semId': semId},
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.deepPurple,
//                   onPrimary: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
