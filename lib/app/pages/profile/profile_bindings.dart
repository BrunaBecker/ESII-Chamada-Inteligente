import 'package:get/get.dart';

import '../../app_controller.dart';
import 'profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => ProfileController(
        appController: Get.find<AppController>(),
      ),
    );
  }
}
