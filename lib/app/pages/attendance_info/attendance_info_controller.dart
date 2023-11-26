import 'package:flutter/material.dart';
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
  final _searchController = TextEditingController();
  late final AttendanceEntity _selectedAttendance;
  final _allStudents = <StudentEntity>[].obs;
  final _filteredStudents = <StudentEntity>[].obs;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _filters = <StudentAtAttendanceState, bool?>{}.obs;
  final _sortOptions = StudentSort.values.obs;
  final _sortMode = StudentSort.alphabetical.obs;
  final _isAscending = true.obs;

  bool get isLoading => _isLoading.value;
  TextEditingController get searchController => _searchController;
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
    required StudentAtAttendanceState newFilter,
  }) {
    switch (_filters[newFilter]) {
      case false:
        _filters[newFilter] = true;
        break;
      case true:
        _filters[newFilter] = null;
        break;
      case null:
        _filters[newFilter] = false;
        break;
    }
    _filteredStudents.clear();
    _filteredStudents.addAll(searchStudents());
    update();
  }

  List<StudentEntity> filterStudents() {
    final result = <StudentEntity>[];
    result.addAll(_allStudents.where((element) {
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
    return result;
  }

  void changeSortMode({
    required StudentSort newSortMode,
  }) {
    if (sortMode == newSortMode) {
      _isAscending.value = !isAscending;
    } else {
      _sortMode.value = newSortMode;
      _isAscending.value = true;
    }
    sortStudents();
    _filteredStudents.clear();
    _filteredStudents.addAll(searchStudents());
    update();
  }

  void sortStudents() {
    _allStudents.sort((a, b) {
      final statusA = getStudentStatus(a);
      final statusB = getStudentStatus(b);
      if (statusA == null || statusB == null) {
        return 0;
      }
      switch (sortMode) {
        case StudentSort.alphabetical:
          return (isAscending ? 1 : -1) * a.name.compareTo(b.name);
        default:
          final sortState = () {
            switch (sortMode) {
              case StudentSort.presence:
                return StudentAtAttendanceState.present;
              case StudentSort.absence:
                return StudentAtAttendanceState.absent;
              case StudentSort.justification:
                return StudentAtAttendanceState.justified;
              default:
                return StudentAtAttendanceState.absent;
            }
          }();
          final valueA = statusA.studentState == sortState ? 0 : -1;
          final valueB = statusB.studentState == sortState ? 0 : -1;
          return (isAscending ? 1 : -1) * valueB.compareTo(valueA);
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

  void search() {
    _filteredStudents.clear();
    _filteredStudents.addAll(searchStudents());
    update();
  }

  List<StudentEntity> searchStudents() {
    final filterResult = filterStudents();
    final result = <StudentEntity>[];
    result.addAll(filterResult.where((element) {
      return element.name.toLowerCase().contains(
            searchController.text.toLowerCase(),
          );
    }).toList());
    return result;
  }
}
