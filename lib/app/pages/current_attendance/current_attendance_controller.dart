import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums/presence_status.dart';

class CurrentAttendanceController extends GetxController {
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

  int presentStudents() {
    return _currentAttendance["students"].where((student) => student["status"] != null).length;
  }

  void changeStudentPresence({
    required Map<String, dynamic> student,
    required PresenceStatus presence,
  }) {
    student["status"] = presence;
    student["confirmed"] = true;
    update();
  }
}
