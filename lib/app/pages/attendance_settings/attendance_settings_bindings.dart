import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/attendance_provider.dart';
import '../../core/data/providers/api/classroom_provider.dart';
import '../../core/data/repositories/create_attendance_repository.dart';
import '../../core/data/repositories/get_classrooms_by_professor_identifier_repository.dart';
import '../../core/domain/usecases/create_attendance_usecase.dart';
import '../../core/domain/usecases/get_classrooms_by_professor_identifier_usecase.dart';
import 'attendance_settings_controller.dart';

class AttendanceSettingsBindings extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<AttendanceProvider>(
      () => AttendanceProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut<ClassroomProvider>(
      () => ClassroomProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Classrooms By Professor Identifier
    Get.lazyPut(
      () => GetClassroomsByProfessorIdentifierRepository(
        classroomProvider: Get.find<ClassroomProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetClassroomsByProfessorIdentifierUsecase(
        Get.find<GetClassroomsByProfessorIdentifierRepository>(),
      ),
    );
    // Create Attendance
    Get.lazyPut(
      () => CreateAttendanceRepository(
        attendanceProvider: Get.find<AttendanceProvider>(),
      ),
    );
    Get.lazyPut(
      () => CreateAttendanceUsecase(
        Get.find<CreateAttendanceRepository>(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => AttendanceSettingsController(
        appController: Get.find<AppController>(),
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
        getClassroomsByProfessorIdentifier:
            Get.find<GetClassroomsByProfessorIdentifierUsecase>(),
        createAttendance: Get.find<CreateAttendanceUsecase>(),
      ),
    );
  }
}
