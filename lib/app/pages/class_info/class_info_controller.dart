import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/chart_adapter.dart';

class ClassInfoController extends GetxController {
  ClassInfoController({
    required ChartAdapter chart,
  }) : _chart = chart;

  final ChartAdapter _chart;
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedClass;
  DateTimeRange? _selectedDateRange;

  ChartAdapter get chart => _chart;

  bool get isLoading => _isLoading.value;

  Map<String, dynamic> get selectedClass => _selectedClass;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  set selectedDateRange(DateTimeRange? value) {
    _selectedDateRange = value;
    update();
  }

  @override
  void onReady() async {
    _isLoading.value = true;

    // TODO query class attendances
    _selectedClass = Get.arguments["classInfo"];

    _isLoading.value = false;
    super.onReady();
  }
}
