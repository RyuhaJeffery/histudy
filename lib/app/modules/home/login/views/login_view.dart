import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          child: Text(
            'Google Sign',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: (){
            AuthService.to.handleSignIn();
          },
        ),
      ),
    );
  }
}
