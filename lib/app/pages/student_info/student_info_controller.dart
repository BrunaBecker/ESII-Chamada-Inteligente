import 'package:get/get.dart';

import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/statistics_entity.dart';
import '../../core/domain/entities/student_entity.dart';

class StudentInfoController extends GetxController {
  final _isLoading = true.obs;
  late final StudentEntity _selectedStudent;
  late final ClassroomEntity _selectedClass;
  late final StatisticsEntity _statistics;
  late final _waivers = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;

  StudentEntity get selectedStudent => _selectedStudent;
  ClassroomEntity get selectedClass => _selectedClass;
  StatisticsEntity get statistics => _statistics;
  List<Map<String, dynamic>> get waivers => _waivers;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedStudent = Get.arguments["studentInfo"];
    _selectedClass = Get.arguments["classInfo"];
    _statistics = Get.arguments["statistics"];

    // TODO: get waivers
    waivers.addAll([
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
    ]);

    _isLoading.value = false;
    super.onReady();
  }
}
