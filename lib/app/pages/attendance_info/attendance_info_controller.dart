import 'package:get/get.dart';

import '../../core/enums/presence_status.dart';

class AttendanceInfoController extends GetxController {
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedAttendance;

  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedAttendance => _selectedAttendance;
  int get totalPresentStudents => selectedAttendance["students"].where((student) => student["status"] == 1).length;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedAttendance = Get.arguments["attendanceInfo"];

    _isLoading.value = false;
    super.onReady();
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
