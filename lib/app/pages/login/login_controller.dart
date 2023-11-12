import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/usecases/login_professor_usecase.dart';
import '../../core/domain/usecases/login_student_usecase.dart';

class LoginController extends GetxController {
  LoginController({
    required mask,
    required validator,
    required LoginProfessorUsecase loginProfessor,
    required LoginStudentUsecase loginStudent,
  })  : _mask = mask,
        _validator = validator,
        _loginProfessor = loginProfessor,
        _loginStudent = loginStudent;

  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final LoginProfessorUsecase _loginProfessor;
  final LoginStudentUsecase _loginStudent;

  final _isLoading = false.obs;
  final _isVisible = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _registrationController = TextEditingController();
  final _passwordController = TextEditingController();

  MaskAdapter get mask => _mask;
  ValidatorAdapter get validator => _validator;
  bool get isLoading => _isLoading.value;
  bool get isVisible => _isVisible.value;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get registrationController => _registrationController;
  TextEditingController get passwordController => _passwordController;
  LoginProfessorUsecase get loginProfessor => _loginProfessor;
  LoginStudentUsecase get loginStudent => _loginStudent;

  void togglePasswordVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  Future<void> authenticate() async {
    // TODO: validate form and authentication
    _isLoading.value = true;
    debugPrint("Authenticating");
    if (registrationController.text.length == 7) {
      await loginProfessor(
        registrationController.text,
        passwordController.text,
      );
    } else {
      await loginStudent(
        registrationController.text,
        passwordController.text,
      );
    }
    // await Future.delayed(const Duration(seconds: 3));
    debugPrint("Success");
    _isLoading.value = false;
  }
}
