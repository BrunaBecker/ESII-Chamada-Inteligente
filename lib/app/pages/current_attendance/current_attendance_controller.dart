import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/create_student_attendance_status_usecase.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/domain/usecases/get_student_by_identifier_usecase.dart';
import '../../core/domain/usecases/update_attendance_status_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';

class CurrentAttendanceController extends GetxController {
  CurrentAttendanceController({
    required MaskAdapter mask,
    required ValidatorAdapter validator,
    required GetAttendanceStatusesByAttendanceUsecase
        getAttendanceStatusesByAttendance,
    required CreateStudentAttendanceStatusUsecase createStudentAttendanceStatus,
    required GetStudentByIdentifierUsecase getStudentByIdentifier,
    required UpdateAttendanceStatusUsecase updateAttendanceStatus,
  })  : _mask = mask,
        _validator = validator,
        _getAttendanceStatusesByAttendance = getAttendanceStatusesByAttendance,
        _createStudentAttendanceStatus = createStudentAttendanceStatus,
        _getStudentByIdentifier = getStudentByIdentifier,
        _updateAttendanceStatus = updateAttendanceStatus;

  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final GetAttendanceStatusesByAttendanceUsecase
      _getAttendanceStatusesByAttendance;
  final CreateStudentAttendanceStatusUsecase _createStudentAttendanceStatus;
  final GetStudentByIdentifierUsecase _getStudentByIdentifier;
  final UpdateAttendanceStatusUsecase _updateAttendanceStatus;

  final _isLoading = true.obs;
  late final AttendanceEntity _currentAttendance;
  final _attendanceStatuses = <AttendanceStatusEntity>[].obs;
  final _allStudents = <StudentEntity>[].obs;
  final _students = <StudentEntity>[].obs;
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();

  MaskAdapter get mask => _mask;
  ValidatorAdapter get validator => _validator;

  bool get isLoading => _isLoading.value;
  AttendanceEntity get currentAttendance => _currentAttendance;
  List<AttendanceStatusEntity> get attendanceStatuses => _attendanceStatuses;
  List<StudentEntity> get allStudents => _allStudents;
  List<StudentEntity> get students => _students;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get searchController => _searchController;
  TextEditingController get nameController => _nameController;
  TextEditingController get registrationController => _registrationController;
  VirtualZoneEntity? get virtualZone => currentAttendance.virtualZone;
  int get totalStudents => students.length;
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
    allStudents.addAll(currentAttendance.classroom?.students ?? []);
    await fetch();
    students.addAll(allStudents);

    _isLoading.value = false;
  }

  Future<void> changeStudentPresence({
    required AttendanceStatusEntity? attendanceStatus,
    required StudentEntity student,
    required StudentAtAttendanceState presence,
  }) async {
    if (attendanceStatus == null) {
      attendanceStatus = AttendanceStatusEntity(
        student: student,
        studentState: presence,
        studentHasResponded: true,
        validated: true,
        attendance: currentAttendance,
      );
      attendanceStatuses.add(attendanceStatus);
    } else {
      attendanceStatus.studentState = presence;
      attendanceStatus.studentHasResponded = true;
      attendanceStatus.validated = true;
    }
    try {
      await _updateAttendanceStatus(attendanceStatus: attendanceStatus);
    } catch (_) {
      Get.snackbar(
        'Erro',
        'Não foi possível atualizar o status do aluno',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    update();
  }

  Future<void> addStudent() async {
    try {
      final student =
          await _getStudentByIdentifier(_registrationController.text);
      final newAttendanceStatus = await _createStudentAttendanceStatus(
        attendanceStatus: AttendanceStatusEntity(
          studentState: StudentAtAttendanceState.present,
          student: student,
          attendance: currentAttendance,
          studentHasResponded: true,
          validated: true,
        ),
      );
      allStudents.add(student);
      students.add(student);
      attendanceStatuses.add(newAttendanceStatus);
    } catch (_) {}
    _nameController.clear();
    _registrationController.clear();
    update();
  }

  Future<void> fetch() async {
    await fetchAttendanceStatuses();
  }

  Future<void> fetchAttendanceStatuses() async {
    _isLoading.value = true;
    attendanceStatuses.clear();
    try {
      final attendanceStatusesResult = await _getAttendanceStatusesByAttendance(
        _currentAttendance.id!,
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
    _isLoading.value = false;
  }

  AttendanceStatusEntity? getStudentStatus(StudentEntity student) {
    return attendanceStatuses.firstWhereOrNull(
      (element) => element.student.id == student.id,
    );
  }

  Future<void> searchStudent(String query) async {
    students.clear();
    students.addAll(allStudents.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }));
    update();
  }
}
