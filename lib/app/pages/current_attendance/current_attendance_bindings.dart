import 'package:get/get.dart';

import 'current_attendance_controller.dart';

class CurrentAttendanceBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => CurrentAttendanceController(),
    );
  }
}
