import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginCOntroller
  final cEmail = TextEditingController();
  final cPass = TextEditingController();

  @override
  void onClose() {
    cEmail.dispose();
    cPass.dispose();
    super.dispose();
  }
}
