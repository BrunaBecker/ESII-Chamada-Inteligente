import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/location_entity.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/get_location_by_id_usecase.dart';
import '../../core/domain/usecases/get_student_attendances_usecase.dart';
import '../../core/exceptions/unexpected_api_exception.dart';
import '../notifications/notifications_controller.dart';

class HomeController extends GetxController {
  HomeController({
    required appController,
    required GetStudentAttendancesUsecase getStudentAttendances,
    required GetLocationByIdUsecase getLocationById,
  })  : _appController = appController,
        _getStudentAttendances = getStudentAttendances,
        _getLocationById = getLocationById;

  final AppController _appController;
  final GetStudentAttendancesUsecase _getStudentAttendances;
  final GetLocationByIdUsecase _getLocationById;

  final _isLoading = true.obs;
  final _attendance = Rx<AttendanceEntity?>(null);
  final _location = Rx<LocationEntity?>(null);

  bool get isLoading => _isLoading.value;
  UserType? get userType => _appController.userType;
  PersonEntity get user => _appController.user!;
  AttendanceEntity? get attendance => _attendance.value;
  LocationEntity? get location => _location.value;
  ClassroomEntity? get classroom => attendance?.classroom;
  VirtualZoneEntity? get virtualZone => attendance?.virtualZone;
  // TODO: get address text
  String? get address => "Endereço";

  @override
  void onReady() {
    super.onReady();

    final notificationsController = Get.find<NotificationsController>();
    notificationsController.fetch();
    fetchAttendance();

    _isLoading.value = false;
  }

  Future<void> fetch() async {
    await Future.wait([
      fetchAttendance(),
      fetchLocation(),
    ]);
  }

  Future<void> fetchAttendance() async {
    try {
      final attendancesResult = await _getStudentAttendances(
        studentId: user.id!,
      );
      if (attendancesResult != null && attendancesResult.isNotEmpty) {
        _attendance.value = attendancesResult.first;
      } else {
        throw UnexpectedApiException();
      }
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
}
