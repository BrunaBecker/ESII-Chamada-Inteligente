import 'package:get/get.dart';

import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';

class AttendanceInfoController extends GetxController {
  AttendanceInfoController({
    required GetAttendanceStatusesByAttendanceUsecase
        getAttendanceStatusesByAttendance,
  }) : _getAttendanceStatusesByAttendance = getAttendanceStatusesByAttendance;

  final GetAttendanceStatusesByAttendanceUsecase
      _getAttendanceStatusesByAttendance;

  final _isLoading = true.obs;
  late final AttendanceEntity _selectedAttendance;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _filters = <String, dynamic>{}.obs;
  final _sortOptions = [].obs;
  final _sortMode = "".obs;
  final _isAscending = true.obs;

  bool get isLoading => _isLoading.value;
  AttendanceEntity get selectedAttendance => _selectedAttendance;
  List<AttendanceStatusEntity> get attendanceStatuses => _attendanceStatuses;
  Map<String, dynamic> get filters => _filters;
  List get sortOptions => _sortOptions;
  String get sortMode => _sortMode.value;
  bool get isAscending => _isAscending.value;
  int get totalStudents => _selectedAttendance.classroom?.students?.length ?? 0;
  int get totalPresentStudents => 0;

  @override
  void onReady() async {
    _isLoading.value = true;

    await fetch();
    _sortMode.value = sortOptions.first;

    _isLoading.value = false;
    super.onReady();
  }

  void changeStudentPresence({
    required AttendanceStatusEntity attendanceStatus,
    required StudentAtAttendanceState presence,
  }) {
    attendanceStatus.studentState = presence;
    attendanceStatus.validated = true;
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

  Future<void> fetch() async {
    await fetchAttendanceStatuses();
  }

  Future<void> fetchAttendanceStatuses() async {
    attendanceStatuses.clear();
    try {
      final attendanceStatusesResult = await _getAttendanceStatusesByAttendance(
        _selectedAttendance.id!,
      );
      attendanceStatuses.addAll(attendanceStatusesResult);
    } catch (_) {}
  }

  AttendanceStatusEntity? getStudentStatus(StudentEntity student) {
    return attendanceStatuses.firstWhereOrNull(
      (element) => element.student.id == student.id,
    );
  }
}
