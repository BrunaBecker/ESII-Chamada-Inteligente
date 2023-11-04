import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import 'attendance_settings_controller.dart';

class AttendanceSettingsBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => AttendanceSettingsController(
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
      ),
    );
  }
}
