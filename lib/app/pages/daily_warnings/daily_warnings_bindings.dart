import 'package:get/get.dart';

import 'daily_warnings_controller.dart';

class DailyWarningsBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.put<DailyWarningsController>(
      DailyWarningsController(),
    );
  }
}
