import 'package:get/get.dart';

import '../../core/adapters/chart_adapter.dart';
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
      ),
    );
    Get.lazyPut(
      () => ClassesController(),
    );
  }
}
