import 'package:get/get.dart';

import '../../core/enums/student_at_attendance_state.dart';

class AttendanceInfoController extends GetxController {
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedAttendance;
  final _filters = <String, dynamic>{}.obs;
  final _sortOptions = [].obs;
  final _sortMode = "".obs;
  final _isAscending = true.obs;

  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedAttendance => _selectedAttendance;
  Map<String, dynamic> get filters => _filters;
  List get sortOptions => _sortOptions;
  String get sortMode => _sortMode.value;
  bool get isAscending => _isAscending.value;
  int get totalPresentStudents => selectedAttendance["students"].where((student) => student["status"] == 1).length;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedAttendance = Get.arguments["attendanceInfo"];
    _filters.value = {
      "Presença": 0,
      "Faltas": 0,
      "Faltas abonadas": 0,
    };
    _sortOptions.value = [
      "Alfabeticamente",
      "Presença",
      "Faltas",
      "Faltas abonadas",
    ];
    _sortMode.value = sortOptions.first;

    _isLoading.value = false;
    super.onReady();
  }

  void changeStudentPresence({
    required Map<String, dynamic> student,
    required StudentAtAttendanceState presence,
  }) {
    student["status"] = presence;
    student["confirmed"] = true;
    update();
  }

  void toggleFilter({
    required String filter,
  }) {
    // TODO: implement filter
    _filters[filter] = (_filters[filter] + 1) % 3;
    update();
  }

  void changeSortMode({
    required String sortMode,
  }) {
    // TODO: implement sort
    if (_sortMode.value == sortMode) {
      _isAscending.value = !_isAscending.value;
    } else {
      _sortMode.value = sortMode;
      _isAscending.value = true;
    }
    update();
  }
}
