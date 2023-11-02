import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/enums/presence_status.dart';

class CurrentAttendanceController extends GetxController {
  CurrentAttendanceController({
    required MaskAdapter maskAdapter,
  }) : _maskAdapter = maskAdapter;

  final MaskAdapter _maskAdapter;

  final _isLoading = true.obs;
  late final Map<String, dynamic> _currentAttendance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();

  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get currentAttendance => _currentAttendance;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get registrationController => _registrationController;
  MaskAdapter get maskAdapter => _maskAdapter;

  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(seconds: 1));
    _currentAttendance = Get.arguments["currentAttendance"];

    _isLoading.value = false;
  }

  int totalStudents() {
    return _currentAttendance["students"].length;
  }

  int answeredStudents() {
    return _currentAttendance["students"].where((student) => student["answered"] as bool).length;
  }

  void changeStudentPresence({
    required Map<String, dynamic> student,
    required PresenceStatus presence,
  }) {
    student["status"] = presence;
    student["answered"] = true;
    student["confirmed"] = true;
    update();
  }

  Future<void> addStudent() async {
    _currentAttendance["students"].add({
      "name": _nameController.text,
      "status": PresenceStatus.present,
      "answered": true,
      "confirmed": true,
      "registration": _registrationController.text,
      "justifications": [],
    });
    _nameController.clear();
    _registrationController.clear();
    update();
  }
}
