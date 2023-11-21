import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/chart_adapter.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/attendance_provider.dart';
import '../../core/data/providers/api/attendance_status_provider.dart';
import '../../core/data/providers/api/classroom_provider.dart';
import '../../core/data/repositories/get_classroom_attendances_repository.dart';
import '../../core/data/repositories/get_student_attendance_statuses_by_classroom_repository.dart';
import '../../core/domain/usecases/get_classroom_attendances_usecase.dart';
import '../../core/domain/usecases/get_student_attendance_statuses_by_classroom_usecase.dart';
import '../classes/classes_controller.dart';
import 'class_info_controller.dart';

class ClassInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Adapter
    Get.lazyPut(
      () => ChartAdapter(),
    );

    // Providers
    Get.lazyPut<ClassroomProvider>(
      () => ClassroomProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut<AttendanceProvider>(
      () => AttendanceProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut<AttendanceStatusProvider>(
      () => AttendanceStatusProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Classroom Attendances
    Get.lazyPut(
      () => GetClassroomAttendancesRepository(
        attendanceProvider: Get.find<AttendanceProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetClassroomAttendancesUsecase(
        Get.find<GetClassroomAttendancesRepository>(),
      ),
    );

    // Get Student Attendance Statuses By Classroom
    Get.lazyPut(
      () => GetStudentAttendanceStatusesByClassroomRepository(
        attendanceStatusProvider: Get.find<AttendanceStatusProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentAttendanceStatusesByClassroomUsecase(
        Get.find<GetStudentAttendanceStatusesByClassroomRepository>(),
      ),
    );

    // Controllers
    Get.lazyPut(
      () => ClassInfoController(
        appController: Get.find<AppController>(),
        classesController: Get.find<ClassesController>(),
        chart: Get.find<ChartAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
        getClassroomAttendances: Get.find<GetClassroomAttendancesUsecase>(),
        getStudentAttendanceStatusesByClassroomUsecase:
            Get.find<GetStudentAttendanceStatusesByClassroomUsecase>(),
      ),
    );
  }
}
