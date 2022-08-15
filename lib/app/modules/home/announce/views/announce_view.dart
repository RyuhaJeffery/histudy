import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/announce_controller.dart';

class AnnounceView extends GetView<AnnounceController> {
  final CollectionReference _announce =
      FirebaseFirestore.instance.collection('Announcement');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child: Container(
          child: Column(
            children: [
              topBar(Get.rootDelegate.parameters["semId"]),
              SizedBox(
                height: 30.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '공지사항',
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
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          '  NO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          '  작성자',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          '  제목',
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
                    child: StreamBuilder(
                      stream: _announce
                          .orderBy('creationTime', descending: true)
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
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(child: Text('${index + 1}')),
                                          Expanded(
                                              child: Text(
                                                  documentSnapshot['author'])),
                                          Expanded(
                                              child: Text(
                                                  documentSnapshot['title'])),
                                          // Expanded(child: Text(documentSnapshot['sem'].toString())),
                                        ]),
                                    // documentSnapshot['isAdmin'].toString() ?
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}
