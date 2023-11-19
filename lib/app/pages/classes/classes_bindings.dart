import 'package:get/get.dart';

import '../../app_controller.dart';
import 'classes_controller.dart';

class ClassesBindings extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut(
      () => ClassesController(
        appController: Get.find<AppController>(),
      ),
    );
  }
}
