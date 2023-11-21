import 'dart:math';

import 'package:get/get.dart';

import '../../core/enums/student_at_attendance_state.dart';
import '../../core/utils/app_date_utils.dart';

class StudentInfoController extends GetxController {
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedStudent;
  late final Map<String, dynamic> _selectedClass;

  bool get isLoading => _isLoading.value;

  Map<String, dynamic> get selectedStudent => _selectedStudent;

  Map<String, dynamic> get selectedClass => _selectedClass;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedStudent = {
      "name": "Aluno 1",
      "status": StudentAtAttendanceState.fromInt(Random().nextInt(3)),
      "confirmed": Random().nextInt(3) != 1,
      "registration":
          "120031${Random().nextInt(100).toString().padLeft(3, "0")}",
      "justifications": [
        {
          "date": DateTime(2023, 10, 03),
          "file": null,
          "title": "Quebrei a perna",
          "description":
              "Eu quebrei a perna, professor, não consigo ir até a faculdade.",
          "attach_file": null,
          "approved": null,
        },
        {
          "date": DateTime(2023, 10, 05),
          "file": null,
          "title": "Quebrei o braço.",
          "description":
              "Eu quebrei o braço, professor, não consigo ir até a faculdade.",
          "attach_file": null,
          "approved": null,
        },
      ],
    };
    _selectedClass = {
      "code": "TCC00${293}",
      "name": "Engenharia de Software 2",
      "class": "A1",
      "activeAttendance": false,
      "attendances": List.generate(
        20,
        (index) => {
          "date":
              AppDateUtils.appDateFormat.format(DateTime(2023, 3, index + 1)),
          "description": "Aula ${index + 1} de Engenharia de Software 2",
          "average_time": Random().nextInt(180) + 50,
          "total_students": Random().nextInt(10) + 15,
          "attendanceStatus":
              StudentAtAttendanceState.fromInt(Random().nextInt(3)),
          "statusVerified": Random().nextInt(3) != 1,
        },
      ),
    };

    _isLoading.value = false;
    super.onReady();
  }
}
