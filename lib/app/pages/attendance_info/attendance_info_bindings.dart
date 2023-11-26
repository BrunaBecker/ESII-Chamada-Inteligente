import 'package:get/get.dart';

import '../../core/adapters/http_adapter.dart';
import '../../core/data/providers/api/attendance_status_provider.dart';
import '../../core/data/repositories/get_attendance_statuses_by_attendance_repository.dart';
import '../../core/data/repositories/update_attendance_status_repository.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import '../../core/domain/usecases/update_attendance_status_usecase.dart';
import 'attendance_info_controller.dart';

class AttendanceInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut(
      () => AttendanceStatusProvider(
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
      () => AttendanceInfoController(
        getAttendanceStatusesByAttendance:
            Get.find<GetAttendanceStatusesByAttendanceUsecase>(),
        updateAttendanceStatus: Get.find<UpdateAttendanceStatusUsecase>(),
      ),
    );
  }
}
