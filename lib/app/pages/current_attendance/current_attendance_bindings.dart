import 'package:get/get.dart';

import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/attendance_status_provider.dart';
import '../../core/data/repositories/get_attendance_statuses_by_attendance_repository.dart';
import '../../core/domain/usecases/get_attendance_statuses_by_attendance_usecase.dart';
import 'current_attendance_controller.dart';

class CurrentAttendanceBindings extends Bindings {
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

    // Controller
    Get.lazyPut(
      () => CurrentAttendanceController(
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
        getAttendanceStatusesByAttendance:
            Get.find<GetAttendanceStatusesByAttendanceUsecase>(),
      ),
    );
  }
}
