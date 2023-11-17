import 'package:get/get.dart';

import '../../core/adapters/chart_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../classes/classes_controller.dart';
import 'class_info_controller.dart';

class ClassInfoBindings extends Bindings {
  @override
  void dependencies() {
    // Adapter
    Get.lazyPut(
      () => ChartAdapter(),
    );

    // Controllers
    Get.lazyPut(
      () => ClassInfoController(
        chart: Get.find<ChartAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
      ),
    );
    Get.lazyPut(
      () => ClassesController(),
    );
  }
}
