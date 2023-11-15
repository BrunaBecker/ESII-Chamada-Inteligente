import 'dart:math';

import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../../core/utils/app_date_utils.dart';

class ClassesController extends GetxController {
  final _isLoading = false.obs;
  final _classesList = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;

  List<Map<String, dynamic>> get classesList => _classesList;
  UserType? get userType => Get.find<AppController>().userType;
  bool get isProfessor => userType == UserType.professor;

  @override
  void onReady() {
    _isLoading.value = true;
    // TODO: get classes
    final students = List.generate(
      Random().nextInt(10) + 15,
      (index) => {
        "name": "Aluno ${index + 1}",
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
      },
    );
    for (var i = 1; i < 21; i++) {
      classesList.add({
        "code": "TCC00${291 + i}",
        "name": "Engenharia de Software $i",
        "class": "A1",
        "activeAttendance": false,
        "attendances": List.generate(
          20,
          (index) => {
            "date": AppDateUtils.appDateFormat.format(DateTime(2023, 3, index + 1)),
            "description": "Aula ${index + 1} de Engenharia de Software $i",
            "average_time": Random().nextInt(180) + 50,
            "total_students": Random().nextInt(10) + 15,
            "students": students,
            "attendanceStatus": StudentAtAttendanceState.fromInt(Random().nextInt(3)),
            "statusVerified": Random().nextInt(3) != 1,
          },
        ),
        "students": students,
      });
    }
    classesList[0]["activeAttendance"] = true;
    classesList[1]["activeAttendance"] = true;

    _isLoading.value = false;
    super.onReady();
  }

  void toggleAttendance(int index) {
    classesList[index]["activeAttendance"] = !classesList[index]["activeAttendance"]!;
    update();
  }
}
