import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceSettingsController extends GetxController {
  final _isLoading = true.obs;
  final _isStartingAttendance = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _allClassList = <String>[].obs;
  final _searchClassList = <String>[].obs;
  final _selectedClass = "".obs;
  final _manualEnd = false.obs;
  final _saveSettings = false.obs;
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  bool get isLoading => _isLoading.value;
  bool get isCreatingAttendance => _isStartingAttendance.value;
  GlobalKey<FormState> get formKey => _formKey;
  List<String> get classList => _allClassList;
  List<String> get searchClassList => _searchClassList;
  String get selectedClass => _selectedClass.value;
  bool get manualEnd => _manualEnd.value;
  bool get saveSettings => _saveSettings.value;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  @override
  void onReady() async {
    super.onReady();

    // TODO: get classes
    await Future.delayed(const Duration(seconds: 1));
    _allClassList.addAll([
      "ENGENHARIA DE SOFTWARE II - A1",
      "PROGRAMAÇÃO I - A1",
      "PROGRAMAÇÃO I - B1",
      "PROGRAMAÇÃO I - C1",
      "PROGRAMAÇÃO ORIENTADA A OBJETOS - A1",
      "PROGRAMAÇÃO ORIENTADA A OBJETOS - B1",
      "PROGRAMAÇÃO ORIENTADA A OBJETOS - C1",
      "ESTRUTURAS DE DADOS E SEUS ALGORITMOS - A1",
      "ESTRUTURAS DE DADOS E SEUS ALGORITMOS - B1",
    ]);
    _selectedClass.value = _allClassList.first;

    _searchClassList.addAll(_allClassList);
    _isLoading.value = false;
  }

  void searchClass(String query) {
    _searchClassList.clear();
    _searchClassList.addAll(_allClassList.where((element) {
      return element.toLowerCase().contains(query.toLowerCase());
    }));
  }

  void toggleManualEnd() {
    _manualEnd.value = !_manualEnd.value;
  }

  void toggleSaveSettings() {
    _saveSettings.value = !_saveSettings.value;
  }

  void changeClass(String value) {
    _selectedClass.value = value;
  }

  Future<void> startAttendance() async {
    _isStartingAttendance.value = true;
    await Future.delayed(const Duration(seconds: 2));
    _isStartingAttendance.value = false;
  }
}
