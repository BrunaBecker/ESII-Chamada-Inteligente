import 'package:get/get.dart';

import 'settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => SettingsController(),
    );
  }
}
