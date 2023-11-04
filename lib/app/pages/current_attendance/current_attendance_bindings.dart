import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import 'current_attendance_controller.dart';

class CurrentAttendanceBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => CurrentAttendanceController(
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
      ),
    );
  }
}
