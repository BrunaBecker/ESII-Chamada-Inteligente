import 'package:get/get.dart';

import '../../app_controller.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => HomeController(
        appController: Get.find<AppController>(),
      ),
    );
  }
}
