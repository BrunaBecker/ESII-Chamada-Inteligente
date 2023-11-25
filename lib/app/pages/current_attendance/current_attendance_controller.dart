import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';

class CurrentAttendanceController extends GetxController {
  CurrentAttendanceController({
    required MaskAdapter mask,
    required ValidatorAdapter validator,
    required GetAttendanceStatusesByAttendanceUsecase
        getAttendanceStatusesByAttendance,
  })  : _mask = mask,
        _validator = validator,
        _getAttendanceStatusesByAttendance = getAttendanceStatusesByAttendance;

  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final GetAttendanceStatusesByAttendanceUsecase
      _getAttendanceStatusesByAttendance;

  final _isLoading = true.obs;
  late final AttendanceEntity _currentAttendance;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();

  MaskAdapter get mask => _mask;
  ValidatorAdapter get validator => _validator;

  bool get isLoading => _isLoading.value;
  AttendanceEntity get currentAttendance => _currentAttendance;
  List<AttendanceStatusEntity> get attendanceStatuses => _attendanceStatuses;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get registrationController => _registrationController;
  VirtualZoneEntity? get virtualZone => currentAttendance.virtualZone;
  int get totalStudents => currentAttendance.classroom?.students?.length ?? 0;
  int get totalAnsweredStudents => _attendanceStatuses
      .where(
        (attendanceStatus) =>
            attendanceStatus.studentState == StudentAtAttendanceState.present,
      )
      .length;

  @override
  void onReady() async {
    super.onReady();

    _currentAttendance = Get.arguments["currentAttendance"];
    fetch();

    _isLoading.value = false;
  }

  void changeStudentPresence({
    required AttendanceStatusEntity? attendanceStatus,
    required StudentEntity student,
    required StudentAtAttendanceState presence,
  }) {
    if (attendanceStatus == null) {
      final newAttendanceStatus = AttendanceStatusEntity(
        student: student,
        studentState: presence,
        studentHasResponded: true,
        validated: true,
        attendance: currentAttendance,
      );
      // TODO: create new attendance status
      attendanceStatuses.add(newAttendanceStatus);
    } else {
      attendanceStatus.studentState = presence;
      attendanceStatus.studentHasResponded = true;
      attendanceStatus.validated = true;
    }

    update();
  }

  Future<void> addStudent() async {
    // _currentAttendance["students"].add({
    //   "name": _nameController.text,
    //   "status": StudentAtAttendanceState.present,
    //   "answered": true,
    //   "confirmed": true,
    //   "registration": _registrationController.text,
    //   "justifications": [],
    //   "virtualZone": null,
    // });
    _nameController.clear();
    _registrationController.clear();
    update();
  }

  Future<void> fetch() async {
    await fetchAttendanceStatuses();
  }

  Future<void> fetchAttendanceStatuses() async {
    attendanceStatuses.clear();
    try {
      final attendanceStatusesResult = await _getAttendanceStatusesByAttendance(
        _currentAttendance.id!,
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
