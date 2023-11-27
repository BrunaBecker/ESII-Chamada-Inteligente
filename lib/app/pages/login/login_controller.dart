import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../app_routes.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/storage_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/credential_entity.dart';
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
    required storage,
    required LoginProfessorUsecase loginProfessor,
    required LoginStudentUsecase loginStudent,
  })  : _appController = appController,
        _mask = mask,
        _validator = validator,
        _storage = storage,
        _loginProfessor = loginProfessor,
        _loginStudent = loginStudent;

  final AppController _appController;
  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final StorageAdapter _storage;
  final LoginProfessorUsecase _loginProfessor;
  final LoginStudentUsecase _loginStudent;

  final _isLoading = true.obs;
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

  @override
  void onReady() async {
    super.onReady();
    _isLoading.value = true;
    await authenticateFromInitialization();
    _isLoading.value = false;
  }

  void togglePasswordVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  void toggleErrorScreen() {
    _showErrorScreen.value = !_showErrorScreen.value;
  }

  Future<void> authenticate({
    required String identifier,
    required String password,
  }) async {
    _isLoading.value = true;
    try {
      if (identifier.length == 7) {
        ProfessorEntity? professor = await loginProfessor(
          identifier,
          password,
        );
        if (professor != null) {
          _appController.user = professor;
          _appController.userType = UserType.professor;
        }
      } else {
        StudentEntity? student = await loginStudent(
          identifier,
          password,
        );
        if (student != null) {
          _appController.user = student;
          _appController.userType = UserType.student;
        }
      }
      if (_appController.user != null) {
        await _storage.saveAuthData(
          identifier: identifier,
          password: password,
        );
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

  Future<void> authenticateFromLogin() async {
    await authenticate(
      identifier: registrationController.text,
      password: passwordController.text,
    );
  }

  Future<void> authenticateFromInitialization() async {
    try {
      CredentialEntity? credential = await _storage.getAuthData();
      if (credential != null) {
        await authenticate(
          identifier: credential.identifier,
          password: credential.password,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } on EntityNotFoundException {
      _errorMessage.value = "Infelizmente não encontramos o seu cadastro";
      _showErrorScreen.value = true;
    } on NoApiResponseException {
      _errorMessage.value =
          "Não foi possível estabelecer uma conexão com o servidor";
      _showErrorScreen.value = true;
    }
  }
}
