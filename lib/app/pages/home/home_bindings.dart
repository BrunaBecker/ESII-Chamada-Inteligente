import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/data/providers/api/attendance_provider.dart';
import '../../core/data/providers/api/location_provider.dart';
import '../../core/data/repositories/get_location_by_id_repository.dart';
import '../../core/data/repositories/get_student_attendances_repository.dart';
import '../../core/domain/usecases/get_location_by_id_usecase.dart';
import '../../core/domain/usecases/get_student_attendances_usecase.dart';
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

    // Get Student Attendances
    Get.lazyPut(
      () => GetStudentAttendancesRepository(
        attendanceProvider: Get.find<AttendanceProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentAttendancesUsecase(
        Get.find<GetStudentAttendancesRepository>(),
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

    // Controller
    Get.lazyPut(
      () => HomeController(
        appController: Get.find<AppController>(),
        getStudentAttendances: Get.find<GetStudentAttendancesUsecase>(),
        getLocationById: Get.find<GetLocationByIdUsecase>(),
      ),
    );
  }
}
