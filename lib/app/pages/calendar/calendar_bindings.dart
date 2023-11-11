import 'package:get/get.dart';

import '../../core/adapters/validator_adapter.dart';
import 'calendar_controller.dart';

class CalendarBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut<CalendarController>(
      () => CalendarController(
        validator: Get.find<ValidatorAdapter>(),
      ),
    );
  }
}
