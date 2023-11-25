import 'package:get/get.dart';

import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/attendance_status_provider.dart';
import '../../core/data/providers/api/student_provider.dart';
import '../../core/data/repositories/create_student_attendance_status_repository.dart';
import '../../core/data/repositories/get_attendance_statuses_by_attendance_repository.dart';
import '../../core/data/repositories/get_student_by_identifier_repository.dart';
import '../../core/data/repositories/update_attendance_status_repository.dart';
import '../../core/domain/usecases/create_student_attendance_status_usecase.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/domain/usecases/get_student_by_identifier_usecase.dart';
import '../../core/domain/usecases/update_attendance_status_usecase.dart';
import 'current_attendance_controller.dart';

class CurrentAttendanceBindings extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut(
      () => AttendanceStatusProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut(
      () => StudentProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Attendance Statuses By Attendance
    Get.lazyPut(
      () => GetAttendanceStatusesByAttendanceRepository(
        attendanceStatusProvider: Get.find<AttendanceStatusProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetAttendanceStatusesByAttendanceUsecase(
        Get.find<GetAttendanceStatusesByAttendanceRepository>(),
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
    // Get Student By Identifier
    Get.lazyPut(
      () => GetStudentByIdentifierRepository(
        studentProvider: Get.find<StudentProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentByIdentifierUsecase(
        Get.find<GetStudentByIdentifierRepository>(),
      ),
    );
    // Update Attendance Status
    Get.lazyPut(
      () => UpdateAttendanceStatusRepository(
        attendanceStatusProvider: Get.find<AttendanceStatusProvider>(),
      ),
    );
    Get.lazyPut(
      () => UpdateAttendanceStatusUsecase(
        Get.find<UpdateAttendanceStatusRepository>(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => CurrentAttendanceController(
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
        getAttendanceStatusesByAttendance:
            Get.find<GetAttendanceStatusesByAttendanceUsecase>(),
        createStudentAttendanceStatus:
            Get.find<CreateStudentAttendanceStatusUsecase>(),
        getStudentByIdentifier: Get.find<GetStudentByIdentifierUsecase>(),
        updateAttendanceStatus: Get.find<UpdateAttendanceStatusUsecase>(),
      ),
    );
  }
}
