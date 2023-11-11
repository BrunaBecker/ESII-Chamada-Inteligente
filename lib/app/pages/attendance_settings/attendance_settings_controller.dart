import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/enums/student_at_attendance_state.dart';
import '../../core/utils/app_date_utils.dart';

class AttendanceSettingsController extends GetxController {
  AttendanceSettingsController({
    required mask,
    required validator,
  })  : _mask = mask,
        _validator = validator;

  final MaskAdapter _mask;
  final ValidatorAdapter _validator;

  final _isLoading = true.obs;
  final _isStartingAttendance = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _allClassList = <String>[].obs;
  final _searchClassList = <String>[].obs;
  final _selectedClass = "".obs;
  final _usePreset = false.obs;
  final _manualEnd = false.obs;
  final _savePreset = false.obs;
  final _dateController = TextEditingController().obs;
  final _startTimeController = TextEditingController().obs;
  final _endTimeController = TextEditingController().obs;

  MaskAdapter get mask => _mask;
  ValidatorAdapter get validator => _validator;
  bool get isLoading => _isLoading.value;
  bool get isCreatingAttendance => _isStartingAttendance.value;
  GlobalKey<FormState> get formKey => _formKey;
  List<String> get classList => _allClassList;
  List<String> get searchClassList => _searchClassList;
  String get selectedClass => _selectedClass.value;
  bool get usePreset => _usePreset.value;
  bool get manualEnd => _manualEnd.value;
  bool get saveSettings => _savePreset.value;
  TextEditingController get dateController => _dateController.value;
  TextEditingController get startTimeController => _startTimeController.value;
  TextEditingController get endTimeController => _endTimeController.value;

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
    if (_allClassList.isNotEmpty) {
      _selectedClass.value = _allClassList.first;
      _searchClassList.addAll(_allClassList);
    }

    _isLoading.value = false;
  }

  void searchClass(String query) {
    _searchClassList.clear();
    _searchClassList.addAll(_allClassList.where((element) {
      return element.toLowerCase().contains(query.toLowerCase());
    }));
  }

  toggleUsePreset() {
    _usePreset.value = !_usePreset.value;

    if (usePreset && selectedClass.isNotEmpty) {
      // TODO: get class settings
      dateController.text = AppDateUtils.appDateFormat.format(DateTime.now());
      startTimeController.text = "09:00";
      endTimeController.text = "11:00";
    }
  }

  disableUsePreset() {
    _usePreset.value = false;
  }

  void toggleManualEnd() {
    _manualEnd.value = !_manualEnd.value;
  }

  void toggleSaveSettings() {
    _savePreset.value = !_savePreset.value;
  }

  void changeClass(String value) {
    _selectedClass.value = value;
  }

  Future<Map<String, dynamic>> startAttendance() async {
    _isStartingAttendance.value = true;
    await Future.delayed(const Duration(seconds: 2));
    final attendance = {
      "name": selectedClass,
      "date": dateController.text,
      "start": startTimeController.text,
      "end": endTimeController.text,
      "zone": null,
      "students": List.generate(
        Random().nextInt(10) + 15,
        (index) => {
          "name": "Aluno ${index + 1}",
          "status": StudentAtAttendanceState.fromInt(Random().nextInt(3)),
          "answered": Random().nextInt(3) != 1,
          "confirmed": Random().nextInt(3) != 1,
          "registration":
              "120031${Random().nextInt(100).toString().padLeft(3, "0")}",
          "justifications": [
            {
              "date": AppDateUtils.appDateFormat.parse(dateController.text),
              "file": null,
              "title": "Quebrei a perna",
              "description":
                  "Eu quebrei a perna, professor, não consigo ir até a faculdade.",
              "attach_file": null,
              "approved": null,
            },
            {
              "date": AppDateUtils.appDateFormat.parse(dateController.text),
              "file": null,
              "title": "Quebrei o braço.",
              "description":
                  "Eu quebrei o braço, professor, não consigo ir até a faculdade.",
              "attach_file": null,
              "approved": null,
            },
          ],
        },
      ),
    };

    _isStartingAttendance.value = false;
    return attendance;
  }

  void changeDate(DateTime date) {
    dateController.text = AppDateUtils.appDateFormat.format(date);
  }

  void changeStartTime(TimeOfDay time) {
    startTimeController.text = AppDateUtils.timeOfDayToAppString(time);
    disableUsePreset();
  }

  void changeEndTime(TimeOfDay time) {
    endTimeController.text = AppDateUtils.timeOfDayToAppString(time);
    disableUsePreset();
  }
}
