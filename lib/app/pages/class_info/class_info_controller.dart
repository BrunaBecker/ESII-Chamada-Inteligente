import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/chart_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/usecases/get_classroom_attendances_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_statuses_by_classroom_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../classes/classes_controller.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({
    required appController,
    required classesController,
    required ChartAdapter chart,
    required validator,
    required GetClassroomAttendancesUsecase getClassroomAttendances,
    required GetStudentAttendanceStatusesByClassroomUsecase
        getStudentAttendanceStatusesByClassroomUsecase,
  })  : _appController = appController,
        _classesController = classesController,
        _chart = chart,
        _validator = validator,
        _getClassroomAttendances = getClassroomAttendances,
        _getStudentAttendanceStatusesByClassroomUsecase =
            getStudentAttendanceStatusesByClassroomUsecase;

  final AppController _appController;
  final ClassesController _classesController;
  final ChartAdapter _chart;
  final ValidatorAdapter _validator;
  final GetClassroomAttendancesUsecase _getClassroomAttendances;
  final GetStudentAttendanceStatusesByClassroomUsecase
      _getStudentAttendanceStatusesByClassroomUsecase;

  final _isLoading = true.obs;
  late final Rx<StudentEntity> _selectedStudent;
  late final Rx<ClassroomEntity> _selectedClassroom;
  late final Rx<AttendanceEntity?> _currentAttendance;
  final _classrooms = <ClassroomEntity>[].obs;
  final _attendances = <AttendanceEntity>[].obs;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _justificationFileNameController = TextEditingController();
  final _justificationTitleController = TextEditingController();
  final _justificationDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectedDateRange;

  ChartAdapter get chart => _chart;
  ValidatorAdapter get validator => _validator;

  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoading => _isLoading.value;

  StudentEntity get selectedStudent => _selectedStudent.value;
  ClassroomEntity get selectedClassroom => _selectedClassroom.value;
  AttendanceEntity? get currentAttendance => _currentAttendance.value;
  List<ClassroomEntity> get classrooms => _classrooms;
  List<AttendanceEntity> get attendances => _attendances;
  List<AttendanceStatusEntity> get attendanceStatuses => _attendanceStatuses;
  DateTimeRange? get selectedDateRange => _selectedDateRange;
  PersonEntity get user => _appController.user!;
  String get userProfileImage => _appController.userProfileImage;
  bool get isProfessor =>
      Get.find<AppController>().userType == UserType.professor;
  TextEditingController get justificationFileNameController =>
      _justificationFileNameController;
  TextEditingController get justificationTitleController =>
      _justificationTitleController;
  TextEditingController get justificationDescriptionController =>
      _justificationDescriptionController;

  set selectedDateRange(DateTimeRange? value) {
    _selectedDateRange = value;
    update();
  }

  @override
  void onReady() async {
    _isLoading.value = true;

    if (!_appController.isProfessor) {
      _selectedStudent = Rx<StudentEntity>(
        _appController.user! as StudentEntity,
      );
    }
    _selectedClassroom = Rx<ClassroomEntity>(Get.arguments["classInfo"]);
    _currentAttendance =
        Rx<AttendanceEntity?>(Get.arguments["activeAttendance"]);
    _classrooms.clear();
    _classrooms.addAll(Get.arguments["classrooms"]);
    await fetchAttendances();
    await fetchAttendanceStatuses();

    _isLoading.value = false;
    super.onReady();
  }

  void filterAttendancesByDate(DateTime start, DateTime end) {
    // TODO: filter attendances by date
    update();
  }

  Future<void> fetch() async {
    _isLoading.value = true;
    attendances.clear();
    try {
      fetchAttendances();
      _classesController.fetch();
      classrooms.clear();
      classrooms.addAll(_classesController.classrooms);
      _currentAttendance.value = _classesController.currentAttendance;
    } catch (_) {}
    _isLoading.value = false;
  }

  Future<void> fetchAttendances() async {
    try {
      attendances.clear();
      final attendancesResult = await _getClassroomAttendances(
        _selectedClassroom.value.id!,
      );
      if (attendancesResult != null) {
        attendances.addAll(attendancesResult);
      }
    } catch (_) {}
  }

  Future<void> fetchAttendanceStatuses() async {
    if (_appController.isProfessor) return;
    try {
      attendanceStatuses.clear();
      final attendanceStatusesResult =
          await _getStudentAttendanceStatusesByClassroomUsecase(
        studentId: selectedStudent.id!,
        classroomId: selectedClassroom.id!,
      );
      if (attendanceStatusesResult != null) {
        attendanceStatuses.addAll(attendanceStatusesResult);
      }
    } catch (_) {}
  }

  StudentAtAttendanceState getSelectedStudentAttendanceStatus({
    required int attendanceId,
  }) {
    try {
      return attendanceStatuses
          .firstWhere((element) => element.attendance.id! == attendanceId)
          .studentState;
    } catch (_) {
      return StudentAtAttendanceState.absent;
    }
  }

  bool getSelectedStudentAttendanceStatusVerified({
    required int attendanceId,
  }) {
    try {
      return attendanceStatuses
          .firstWhere((element) => element.attendance.id! == attendanceId)
          .validated;
    } catch (_) {
      return false;
    }
  }
}
