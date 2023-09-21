import 'package:get/get.dart';

import 'attendance_settings_controller.dart';

class AttendanceSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceSettingsController());
  }
}
