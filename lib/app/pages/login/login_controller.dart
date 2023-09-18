import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;

  final _isVisible = false.obs;

  bool get isLoading => _isLoading.value;

  bool get isVisible => _isVisible.value;

  void togglePasswordVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  Future<void> authenticate() async {
    // TODO: validate form and authentication
    _isLoading.value = true;
    debugPrint("Authenticating");
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("Success");
    _isLoading.value = false;
  }
}
