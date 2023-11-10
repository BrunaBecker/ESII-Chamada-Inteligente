import 'package:get/get.dart';

import '../../core/adapters/chart_adapter.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({
    required ChartAdapter chart,
  }) : _chart = chart;

  final ChartAdapter _chart;
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedClass;

  ChartAdapter get chart => _chart;
  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedClass => _selectedClass;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedClass = Get.arguments["classInfo"];

    _isLoading.value = false;
    super.onReady();
  }

  void filterAttendancesByDate(DateTime start, DateTime end) {
    // TODO: filter attendances by date
    update();
  }
}
