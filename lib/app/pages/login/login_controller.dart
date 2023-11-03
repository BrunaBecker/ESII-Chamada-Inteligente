import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';

class LoginController extends GetxController {
  LoginController({
    required maskAdapter,
    required validatorAdapter,
  })  : _maskAdapter = maskAdapter,
        _validatorAdapter = validatorAdapter;

  final MaskAdapter _maskAdapter;
  final ValidatorAdapter _validatorAdapter;

  final _isLoading = false.obs;
  final _isVisible = false.obs;
  final _formKey = GlobalKey<FormState>();

  MaskAdapter get maskAdapter => _maskAdapter;
  ValidatorAdapter get validatorAdapter => _validatorAdapter;
  bool get isLoading => _isLoading.value;
  bool get isVisible => _isVisible.value;
  GlobalKey<FormState> get formKey => _formKey;

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
