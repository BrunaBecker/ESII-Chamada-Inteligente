import 'package:get/get.dart';

import 'attendance_info_controller.dart';

class AttendanceInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => AttendanceInfoController(),
    );
  }
}
