import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/chart_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/enums/student_at_attendance_state.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({
    required ChartAdapter chart,
    required validator,
  })  : _chart = chart,
        _validator = validator;

  final ChartAdapter _chart;
  final _isLoading = true.obs;
  final ValidatorAdapter _validator;
  late final _selectedClass = <String, dynamic>{}.obs;
  final _selectedStudent = Rx<Map<String, dynamic>?>(null);
  final _justificationFileNameController = TextEditingController();
  final _justificationTitleController = TextEditingController();
  final _justificationDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectedDateRange;

  ChartAdapter get chart => _chart;

  ValidatorAdapter get validator => _validator;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isLoading => _isLoading.value;

  Map<String, dynamic> get selectedClass => _selectedClass;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  set selectedDateRange(DateTimeRange? value) {
    _selectedDateRange = value;
    update();
  }

  Map<String, dynamic>? get selectedStudent => _selectedStudent.value;
  bool get isProfessor => Get.find<AppController>().userType == UserType.professor;
  TextEditingController get justificationFileNameController => _justificationFileNameController;
  TextEditingController get justificationTitleController => _justificationTitleController;
  TextEditingController get justificationDescriptionController => _justificationDescriptionController;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedClass.value = Get.arguments["classInfo"];
    _selectedStudent.value = {
      "name": "Aluno 1",
      "status": StudentAtAttendanceState.fromInt(Random().nextInt(3)),
      "confirmed": Random().nextInt(3) != 1,
      "registration": "120031${Random().nextInt(100).toString().padLeft(3, "0")}",
      "justifications": [
        {
          "date": DateTime(2023, 10, 03),
          "file": null,
          "title": "Quebrei a perna",
          "description": "Eu quebrei a perna, professor, não consigo ir até a faculdade.",
          "attach_file": null,
          "approved": null,
        },
        {
          "date": DateTime(2023, 10, 05),
          "file": null,
          "title": "Quebrei o braço.",
          "description": "Eu quebrei o braço, professor, não consigo ir até a faculdade.",
          "attach_file": null,
          "approved": null,
        },
      ],
    };

    _isLoading.value = false;
    super.onReady();
  }
}
