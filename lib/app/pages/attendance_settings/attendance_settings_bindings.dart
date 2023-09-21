import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import 'attendance_settings_controller.dart';

class AttendanceSettingsBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => AttendanceSettingsController(
        maskAdapter: Get.find<MaskAdapter>(),
      ),
    );
  }
}
