import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/professor_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/usecases/login_professor_usecase.dart';
import '../../core/domain/usecases/login_student_usecase.dart';
import '../../core/exceptions/entity_not_found_exception.dart';
import '../../core/exceptions/no_api_response_exception.dart';

class LoginController extends GetxController {
  LoginController({
    required appController,
    required mask,
    required validator,
    required LoginProfessorUsecase loginProfessor,
    required LoginStudentUsecase loginStudent,
  })  : _appController = appController,
        _mask = mask,
        _validator = validator,
        _loginProfessor = loginProfessor,
        _loginStudent = loginStudent;

  final AppController _appController;
  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final LoginProfessorUsecase _loginProfessor;
  final LoginStudentUsecase _loginStudent;

  final _isLoading = false.obs;
  final _isVisible = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _registrationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _showErrorScreen = false.obs;
  final _errorMessage = "".obs;

  AppController get appController => _appController;
  MaskAdapter get mask => _mask;
  ValidatorAdapter get validator => _validator;

  bool get isLoading => _isLoading.value;
  bool get isVisible => _isVisible.value;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get registrationController => _registrationController;
  TextEditingController get passwordController => _passwordController;
  LoginProfessorUsecase get loginProfessor => _loginProfessor;
  LoginStudentUsecase get loginStudent => _loginStudent;
  bool get showErrorScreen => _showErrorScreen.value;
  String get errorMessage => _errorMessage.value;

  void togglePasswordVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  void toggleErrorScreen() {
    _showErrorScreen.value = !_showErrorScreen.value;
  }

  Future<void> authenticate() async {
    _isLoading.value = true;
    try {
      if (registrationController.text.length == 7) {
        ProfessorEntity? professor = await loginProfessor(
          registrationController.text,
          passwordController.text,
        );
        if (professor != null) {
          _appController.user = professor;
          _appController.userType = UserType.professor;
        }
      } else {
        StudentEntity? student = await loginStudent(
          registrationController.text,
          passwordController.text,
        );
        if (student != null) {
          _appController.user = student;
          _appController.userType = UserType.student;
        }
      }
    } on EntityNotFoundException {
      _errorMessage.value = "Infelizmente não encontramos o seu cadastro";
      _showErrorScreen.value = true;
    } on NoApiResponseException {
      _errorMessage.value =
          "Não foi possível estabelecer uma conexão com o servidor";
      _showErrorScreen.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}
