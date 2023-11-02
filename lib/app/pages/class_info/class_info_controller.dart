import 'package:get/get.dart';

import '../../core/adapters/chart_adapter.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({required ChartAdapter chartAdapter}) : _chartAdapter = chartAdapter;

  final ChartAdapter _chartAdapter;
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedClass;

  ChartAdapter get chartAdapter => _chartAdapter;
  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedClass => _selectedClass;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedClass = Get.arguments["classInfo"];

    _isLoading.value = false;
    super.onReady();
  }
}
