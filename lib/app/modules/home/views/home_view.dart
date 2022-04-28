import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  
  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance
    .collection('Announcement')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["text"]);
        });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
