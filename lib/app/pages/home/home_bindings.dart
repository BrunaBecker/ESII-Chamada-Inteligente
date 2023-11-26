import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/location_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/attendance_provider.dart';
import '../../core/data/providers/api/attendance_status_provider.dart';
import '../../core/data/providers/api/location_provider.dart';
import '../../core/data/providers/api/ping_provider.dart';
import '../../core/data/repositories/create_ping_repository.dart';
import '../../core/data/repositories/create_student_attendance_status_repository.dart';
import '../../core/data/repositories/get_location_by_id_repository.dart';
import '../../core/data/repositories/get_professor_attendance_happening_repository.dart';
import '../../core/data/repositories/get_student_attendance_status_by_attendance_repository.dart';
import '../../core/data/repositories/get_student_attendance_happening_repository.dart';
import '../../core/domain/usecases/create_ping_usecase.dart';
import '../../core/domain/usecases/create_student_attendance_status_usecase.dart';
import '../../core/domain/usecases/get_location_by_id_usecase.dart';
import '../../core/domain/usecases/get_professor_attendance_happening_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_status_by_attendance_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_happening_usecase.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut(
      () => AttendanceProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut(
      () => LocationProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut(
      () => AttendanceStatusProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut<PingProvider>(
      () => PingProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Professor Attendance Happening
    Get.lazyPut(
      () => GetProfessorAttendanceHappeningRepository(
        attendanceProvider: Get.find<AttendanceProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetProfessorAttendanceHappeningUsecase(
        Get.find<GetProfessorAttendanceHappeningRepository>(),
      ),
    );
    // Get Student Attendance Happening
    Get.lazyPut(
      () => GetStudentAttendanceHappeningRepository(
        attendanceProvider: Get.find<AttendanceProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentAttendanceHappeningUsecase(
        Get.find<GetStudentAttendanceHappeningRepository>(),
      ),
    );
    // Get Location By Id
    Get.lazyPut(
      () => GetLocationByIdRepository(
        locationProvider: Get.find<LocationProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetLocationByIdUsecase(
        Get.find<GetLocationByIdRepository>(),
      ),
    );
    // Get Student Attendance Status By Attendance
    Get.lazyPut(
      () => GetStudentAttendanceStatusByAttendanceRepository(
        attendanceStatusProvider: Get.find<AttendanceStatusProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentAttendanceStatusByAttendanceUsecase(
        Get.find<GetStudentAttendanceStatusByAttendanceRepository>(),
      ),
    );
    // Create Student Attendance Status
    Get.lazyPut(
      () => CreateStudentAttendanceStatusRepository(
        attendanceStatusProvider: Get.find<AttendanceStatusProvider>(),
      ),
    );
    Get.lazyPut(
      () => CreateStudentAttendanceStatusUsecase(
        Get.find<CreateStudentAttendanceStatusRepository>(),
      ),
    );
    // Create Ping
    Get.lazyPut(
      () => CreatePingRepository(
        pingProvider: Get.find<PingProvider>(),
      ),
    );
    Get.lazyPut(
      () => CreatePingUsecase(
        Get.find<CreatePingRepository>(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => HomeController(
        appController: Get.find<AppController>(),
        validator: Get.find<ValidatorAdapter>(),
        locationUtils: Get.find<LocationAdapter>(),
        getProfessorAttendanceHappening:
            Get.find<GetProfessorAttendanceHappeningUsecase>(),
        getStudentAttendanceHappening:
            Get.find<GetStudentAttendanceHappeningUsecase>(),
        getLocationById: Get.find<GetLocationByIdUsecase>(),
        getStudentAttendanceStatusByAttendance:
            Get.find<GetStudentAttendanceStatusByAttendanceUsecase>(),
        createPing: Get.find<CreatePingUsecase>(),
      ),
    );
  }
}
