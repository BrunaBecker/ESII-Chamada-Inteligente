import 'dart:math';

import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/chart_adapter.dart';
import '../../core/enums/student_at_attendance_state.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({
    required ChartAdapter chart,
  }) : _chart = chart;

  final ChartAdapter _chart;
  final _isLoading = true.obs;
  late final _selectedClass = <String, dynamic>{}.obs;
  final _selectedStudent = Rx<Map<String, dynamic>?>(null);

  ChartAdapter get chart => _chart;
  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedClass => _selectedClass;
  Map<String, dynamic>? get selectedStudent => _selectedStudent.value;
  bool get isProfessor => Get.find<AppController>().userType == UserType.professor;

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
