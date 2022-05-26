import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/group_info_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../routes/app_pages.dart';

class GroupInfoView extends StatefulWidget {
  const GroupInfoView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GroupInfoView> {
  //var firebaseUser = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _firebaseAuth =
  User? user = FirebaseAuth.instance.currentUser;

  bool admin = false;
  bool loading = true;
  int curuser = 0;

  final CollectionReference _group =
      FirebaseFirestore.instance.collection('Group');

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        admin = ds['isAdmin'];
        curuser = ds['group'];
        loading = false;
      });
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final CollectionReference _profile =
      FirebaseFirestore.instance.collection('Profile');

  bool isSwitched = false;
  User? currentUser;

  Future<void> _createOrUpdate(
      [DocumentSnapshot? documentSnapshot, int? preGroup]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      isSwitched = documentSnapshot['isAdmin'];
      _nameController.text = documentSnapshot['name'];
      _groupController.text = documentSnapshot['group'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _groupController,
                  decoration: const InputDecoration(
                    labelText: 'change group number ',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.grey,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    //final String? name = _nameController.text;
                    final double? group =
                        double.tryParse(_groupController.text);
                    if (group != null) {
                      if (action == 'update') {
                        await _group.doc(preGroup.toString()).update({
                          "members":
                              FieldValue.arrayRemove([documentSnapshot!.id]),
                        });

                        //이동할 그룹에 유저 데이터를 추가
                        await _group.doc(group.toString()).update({
                          "members":
                              FieldValue.arrayUnion([documentSnapshot.id]),
                        });
                        await _profile
                            .doc(documentSnapshot.id)
                            .update({"group": group, "isAdmin": isSwitched});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _groupController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteProduct(String productId) async {
    await _profile.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a profile')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                    Get.rootDelegate.toNamed(Routes.HOME);
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
                  onPressed: () {
                    Get.rootDelegate.toNamed(Routes.MY_PAGE);
                  },
                  child: Text('MY PAGE'))
            ],
          ),
        ]),
      ),
      loading
          ? Container()
          : admin
              ? Flexible(
                  child: Column(children: [
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
                    Row(children: [
                      SizedBox(
                        width: 280.w,
                      ),
                      Expanded(child: Text('  이름')),
                      Expanded(child: Text('  이메일')),
                      Expanded(child: Text('  그룹')),
                      Expanded(child: Text('  관리자')),
                      Expanded(child: Text(' ')),
                    ]),
                    Divider(
                      thickness: 0.1,
                      color: Colors.black,
                      height: 10,
                    ),
                    Flexible(
                      child: StreamBuilder(
                        //stream: _profile.snapshots(),
                        stream: _profile
                            .orderBy('group', descending: true)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(children: [
                                    ListTile(
                                      // title: Text(documentSnapshot['name']),
                                      title: Row(children: <Widget>[
                                        Expanded(child: Text('${index + 1}')),
                                        Expanded(
                                            child:
                                                Text(documentSnapshot['name'])),
                                        Expanded(
                                            child: Text(
                                                documentSnapshot['email']
                                                    .toString())),
                                        Expanded(
                                            child: Text(
                                                documentSnapshot['group']
                                                    .toString())),
                                        Expanded(
                                            child: Text(
                                                documentSnapshot['isAdmin']
                                                    .toString())),
                                      ]),
                                      // documentSnapshot['isAdmin'].toString() ?

                                      trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () =>
                                                    _createOrUpdate(
                                                        documentSnapshot,
                                                        documentSnapshot[
                                                            'group'])),
                                            IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () => _deleteProduct(
                                                    documentSnapshot.id)),
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
                )
              : Flexible(
                  child: Column(children: [
                  Row(children: [
                    Expanded(child: Text('      no.')),
                    Expanded(child: Text('  이름')),
                    Expanded(child: Text('  이메일')),
                    Expanded(child: Text('  그룹')),
                  ]),
                  Divider(
                    thickness: 0.1,
                    color: Colors.black,
                    height: 10,
                  ),
                  Flexible(
                    child: StreamBuilder(
                      stream: _profile
                          .where("group", isEqualTo: curuser)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(children: [
                                  ListTile(
                                      title: Row(children: <Widget>[
                                    Expanded(child: Text('${index + 1}')),
                                    Expanded(
                                        child: Text(documentSnapshot['name'])),
                                    Expanded(
                                        child: Text(documentSnapshot['email']
                                            .toString())),
                                    Expanded(
                                        child: Text(documentSnapshot['group']
                                            .toString())),
                                  ])),
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
                ]))
    ]));
  }
}
