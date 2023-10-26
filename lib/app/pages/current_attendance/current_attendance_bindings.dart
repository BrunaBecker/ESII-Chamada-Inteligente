import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import 'current_attendance_controller.dart';

class CurrentAttendanceBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => CurrentAttendanceController(
        maskAdapter: Get.find<MaskAdapter>(),
      ),
    );
  }
}
