import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../app_routes.dart';
import '../../core/adapters/location_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/attendance_status_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/location_entity.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/domain/entities/student_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/create_student_attendance_status_usecase.dart';
import '../../core/domain/usecases/get_location_by_id_usecase.dart';
import '../../core/domain/usecases/get_professor_attendance_happening_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_happening_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_status_by_attendance_usecase.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../notifications/notifications_controller.dart';

class HomeController extends GetxController {
  HomeController({
    required AppController appController,
    required ValidatorAdapter validator,
    required LocationAdapter locationUtils,
    required GetProfessorAttendanceHappeningUsecase
        getProfessorAttendanceHappening,
    required GetStudentAttendanceHappeningUsecase getStudentAttendanceHappening,
    required GetLocationByIdUsecase getLocationById,
    required GetStudentAttendanceStatusByAttendanceUsecase
        getStudentAttendanceStatusByAttendance,
    required CreateStudentAttendanceStatusUsecase createStudentAttendanceStatus,
  })  : _appController = appController,
        _validator = validator,
        _locationUtils = locationUtils,
        _getProfessorAttendanceHappening = getProfessorAttendanceHappening,
        _getStudentAttendanceHappening = getStudentAttendanceHappening,
        _getLocationById = getLocationById,
        _getStudentAttendanceStatusByAttendance =
            getStudentAttendanceStatusByAttendance,
        _createStudentAttendanceStatus = createStudentAttendanceStatus;

  final AppController _appController;
  final ValidatorAdapter _validator;
  final LocationAdapter _locationUtils;
  final GetProfessorAttendanceHappeningUsecase _getProfessorAttendanceHappening;
  final GetStudentAttendanceHappeningUsecase _getStudentAttendanceHappening;
  final GetLocationByIdUsecase _getLocationById;
  final GetStudentAttendanceStatusByAttendanceUsecase
      _getStudentAttendanceStatusByAttendance;
  final CreateStudentAttendanceStatusUsecase _createStudentAttendanceStatus;

  final _isLoading = true.obs;
  final _attendance = Rx<AttendanceEntity?>(null);
  final _attendanceStatus = Rx<AttendanceStatusEntity?>(null);
  final _location = Rx<LocationEntity?>(null);
  final _address = "".obs;
  final _waiverFileNameController = TextEditingController();
  final _waiverTitleController = TextEditingController();
  final _waiverDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AppController get appController => _appController;
  ValidatorAdapter get validator => _validator;
  bool get isLoading => _isLoading.value;
  UserType? get userType => _appController.userType;
  PersonEntity get user => _appController.user!;
  AttendanceEntity? get attendance => _attendance.value;
  AttendanceStatusEntity? get attendanceStatus => _attendanceStatus.value;
  LocationEntity? get location => _location.value;
  ClassroomEntity? get classroom => attendance?.classroom;
  VirtualZoneEntity? get virtualZone => attendance?.virtualZone;
  String? get address => _address.value;
  TextEditingController get waiverFileNameController =>
      _waiverFileNameController;
  TextEditingController get waiverTitleController => _waiverTitleController;
  TextEditingController get waiverDescriptionController =>
      _waiverDescriptionController;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onReady() async {
    super.onReady();

    final notificationsController = Get.find<NotificationsController>();
    await notificationsController.fetch();
    await fetch();

    if (appController.isProfessor && attendance != null) {
      Get.offAllNamed(
        AppRoutes.currentAttendance,
        arguments: {
          "currentAttendance": attendance!,
        },
      );
    }

    _isLoading.value = false;
  }

  Future<void> fetch() async {
    await fetchAttendance();
    await fetchLocation();
    await fetchAttendanceStatus();
    await fetchAddress();
  }

  Future<void> fetchAttendance() async {
    try {
      final attendancesResult = _appController.isProfessor
          ? await _getProfessorAttendanceHappening(
              professorId: user.id!,
            )
          : await _getStudentAttendanceHappening(
              studentId: user.id!,
            );
      _attendance.value = attendancesResult;
    } catch (_) {
      _attendance.value = null;
    }
  }

  Future<void> fetchLocation() async {
    try {
      if (virtualZone != null) {
        final locationResult = await _getLocationById(
          id: virtualZone!.locationId,
        );
        _location.value = locationResult;
      }
    } catch (_) {
      _location.value = null;
    }
  }

  Future<void> fetchAttendanceStatus() async {
    if (_appController.isProfessor) return;
    try {
      if (attendance != null) {
        final attendanceStatusResult =
            await _getStudentAttendanceStatusByAttendance(
          attendanceId: attendance!.id!,
          studentId: user.id!,
        );
        _attendanceStatus.value = attendanceStatusResult;
      }
    } catch (_) {
      _attendanceStatus.value = null;
    }
  }

  Future<void> fetchAddress() async {
    if (location != null && location!.coordinate != null) {
      _address.value = await _locationUtils.getPlacemarkFromLocationData(
            location!.coordinate!,
          ) ??
          "-";
    } else {
      _address.value = "-";
    }
  }

  Future<void> createAttendanceStatus(StudentAtAttendanceState state) async {
    _attendanceStatus.value = await _createStudentAttendanceStatus(
      attendanceStatus: AttendanceStatusEntity(
        attendance: attendance!,
        student: user as StudentEntity,
        studentState: state,
        studentHasResponded: true,
      ),
    );
  }
}
