import 'package:get/get.dart';

import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../../core/enums/student_sort.dart';

class AttendanceInfoController extends GetxController {
  AttendanceInfoController({
    required GetAttendanceStatusesByAttendanceUsecase
        getAttendanceStatusesByAttendance,
  }) : _getAttendanceStatusesByAttendance = getAttendanceStatusesByAttendance;

  final GetAttendanceStatusesByAttendanceUsecase
      _getAttendanceStatusesByAttendance;

  final _isLoading = true.obs;
  late final AttendanceEntity _selectedAttendance;
  final _allStudents = <StudentEntity>[].obs;
  final _filteredStudents = <StudentEntity>[].obs;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _filters = <StudentAtAttendanceState, bool?>{}.obs;
  final _sortOptions = StudentSort.values.obs;
  final _sortMode = StudentSort.alphabetical.obs;
  final _isAscending = true.obs;

  bool get isLoading => _isLoading.value;
  AttendanceEntity get selectedAttendance => _selectedAttendance;
  List<StudentEntity> get allStudents => _allStudents;
  List<StudentEntity> get filteredStudents => _filteredStudents;
  List<AttendanceStatusEntity> get attendanceStatuses => _attendanceStatuses;
  Map<StudentAtAttendanceState, bool?> get filters => _filters;
  List<StudentSort> get sortOptions => _sortOptions;
  StudentSort get sortMode => _sortMode.value;
  bool get isAscending => _isAscending.value;
  int get totalStudents => _allStudents.length;
  int get totalFilteredStudents => _filteredStudents.length;
  int get totalPresentStudents => _allStudents
      .where((element) =>
          getStudentStatus(element)?.studentState ==
          StudentAtAttendanceState.present)
      .length;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedAttendance = Get.arguments["attendanceInfo"];
    _filters.clear();
    _filters.addAll({
      StudentAtAttendanceState.present: false,
      StudentAtAttendanceState.absent: false,
      StudentAtAttendanceState.justified: false,
    });
    _allStudents.addAll(_selectedAttendance.classroom?.students ?? []);
    await fetch();
    _filteredStudents.clear();
    _filteredStudents.addAll(_allStudents);

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
    required StudentAtAttendanceState filter,
  }) {
    // TODO: implement filter
    switch (_filters[filter]) {
      case false:
        _filters[filter] = true;
        break;
      case true:
        _filters[filter] = null;
        break;
      case null:
        _filters[filter] = false;
        break;
    }
    filterStudents();
    update();
  }

  void filterStudents() {
    if (_sortMode.value == sortMode) {
      _isAscending.value = !_isAscending.value;
    } else {
      _sortMode.value = sortMode;
      _isAscending.value = true;
    }
    _filteredStudents.clear();
    _filteredStudents.addAll(_allStudents.where((element) {
      final status = getStudentStatus(element);
      if (_filters.values.contains(true)) {
        return _filters[
                status?.studentState ?? StudentAtAttendanceState.absent] ??
            false;
      }
      if (_filters.values.contains(null)) {
        return _filters[
                status?.studentState ?? StudentAtAttendanceState.absent] !=
            null;
      }
      return true;
    }).toList());
  }

  void changeSortMode({
    required StudentSort sortMode,
  }) {
    // TODO: implement sort
    if (_sortMode.value == sortMode) {
      _isAscending.value = !_isAscending.value;
    } else {
      _sortMode.value = sortMode;
      _isAscending.value = true;
    }
    sortStudents();
    filterStudents();
    update();
  }

  void sortStudents() {
    _allStudents.sort((a, b) {
      final statusA = getStudentStatus(a);
      final statusB = getStudentStatus(b);
      if (statusA == null || statusB == null) {
        return 0;
      }
      if (_isAscending.value) {
        switch (_sortMode.value) {
          case StudentSort.alphabetical:
            return a.name.compareTo(b.name);
          default:
            return statusA.studentState.toInt().compareTo(
                  statusB.studentState.toInt(),
                );
        }
      } else {
        switch (_sortMode.value) {
          case StudentSort.alphabetical:
            return b.name.compareTo(a.name);
          default:
            return statusB.studentState.toInt().compareTo(
                  statusA.studentState.toInt(),
                );
        }
      }
    });
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
      for (final status in attendanceStatuses) {
        var inList = false;
        for (final student in allStudents) {
          if (status.student.id == student.id) {
            inList = true;
            break;
          }
        }
        if (!inList) {
          allStudents.add(status.student);
        }
      }
    } catch (_) {}
  }

  AttendanceStatusEntity? getStudentStatus(StudentEntity student) {
    return attendanceStatuses.firstWhereOrNull(
      (element) {
        return element.student.id == student.id;
      },
    );
  }
}
