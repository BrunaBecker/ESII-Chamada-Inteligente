import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/professor_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/create_attendance_usecase.dart';
import '../../core/domain/usecases/get_classrooms_by_professor_identifier_usecase.dart';
import '../../core/utils/app_date_utils.dart';

class AttendanceSettingsController extends GetxController {
  AttendanceSettingsController({
    required appController,
    required mask,
    required validator,
    required getClassroomsByProfessorIdentifier,
    required createAttendance,
  })  : _appController = appController,
        _mask = mask,
        _validator = validator,
        _getClassroomsByProfessorIdentifier =
            getClassroomsByProfessorIdentifier,
        _createAttendance = createAttendance;

  final AppController _appController;
  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final GetClassroomsByProfessorIdentifierUsecase
      _getClassroomsByProfessorIdentifier;
  final CreateAttendanceUsecase _createAttendance;

  final _isLoading = true.obs;
  final _isStartingAttendance = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _allClassroomList = <ClassroomEntity>[].obs;
  final _searchClassroomList = <ClassroomEntity>[].obs;
  late final _selectedClassroom = Rx<ClassroomEntity?>(null);
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
  List<ClassroomEntity> get classroomList => _allClassroomList;
  List<ClassroomEntity> get searchClassroomList => _searchClassroomList;
  ClassroomEntity? get selectedClassroom => _selectedClassroom.value;
  bool get usePreset => _usePreset.value;
  bool get manualEnd => _manualEnd.value;
  bool get saveSettings => _savePreset.value;
  TextEditingController get dateController => _dateController.value;
  TextEditingController get startTimeController => _startTimeController.value;
  TextEditingController get endTimeController => _endTimeController.value;
  ProfessorEntity get professor => _appController.user as ProfessorEntity;

  @override
  void onReady() async {
    super.onReady();

    // TODO: get classes
    // await Future.delayed(const Duration(seconds: 1));
    // _allClassList.addAll([
    //   "ENGENHARIA DE SOFTWARE II - A1",
    //   "PROGRAMAÇÃO I - A1",
    //   "PROGRAMAÇÃO I - B1",
    //   "PROGRAMAÇÃO I - C1",
    //   "PROGRAMAÇÃO ORIENTADA A OBJETOS - A1",
    //   "PROGRAMAÇÃO ORIENTADA A OBJETOS - B1",
    //   "PROGRAMAÇÃO ORIENTADA A OBJETOS - C1",
    //   "ESTRUTURAS DE DADOS E SEUS ALGORITMOS - A1",
    //   "ESTRUTURAS DE DADOS E SEUS ALGORITMOS - B1",
    // ]);
    final classroomsResult = await _getClassroomsByProfessorIdentifier(
      professor.register.identifier,
    );
    _allClassroomList.addAll(classroomsResult);
    if (_allClassroomList.isNotEmpty) {
      _selectedClassroom.value = _allClassroomList.first;
      _searchClassroomList.addAll(_allClassroomList);
    }

    _isLoading.value = false;
  }

  void searchClass(String query) {
    _searchClassroomList.clear();
    _searchClassroomList.addAll(_allClassroomList.where((element) {
      return element.courseName.toLowerCase().contains(query.toLowerCase());
    }));
  }

  toggleUsePreset() {
    _usePreset.value = !_usePreset.value;

    if (usePreset && selectedClassroom != null) {
      dateController.text = AppDateUtils.appDateFormat.format(DateTime.now());
      startTimeController.text = parseHour(selectedClassroom!.startHour);
      endTimeController.text = parseHour(selectedClassroom!.endHour);
    }
  }

  disableUsePreset() {
    _usePreset.value = false;
  }

  void toggleManualEnd() {
    _manualEnd.value = !_manualEnd.value;
  }

  void toggleSaveSettings() {
    // TODO: save settings
    _savePreset.value = !_savePreset.value;
  }

  void changeClassroom(ClassroomEntity value) {
    _selectedClassroom.value = value;
  }

  Future<AttendanceEntity?> startAttendance() async {
    _isStartingAttendance.value = true;
    // TODO: get location
    final virtualZone = selectedClassroom!.defaultLocation != null
        ? VirtualZoneEntity(
            locationId: selectedClassroom!.defaultLocation!.id!,
          )
        : null;

    try {
      final attendance = await _createAttendance(
        attendance: AttendanceEntity(
          date: AppDateUtils.appDateFormat.parse(dateController.text),
          supportingText: "",
          startHour: startTimeController.text,
          endHour: endTimeController.text,
          isAutomatic: false,
          isHappening: true,
          virtualZone: virtualZone,
          classroom: selectedClassroom,
        ),
      );
      return attendance;
    } catch (_) {
      return null;
    } finally {
      _isStartingAttendance.value = false;
    }
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

  String parseHour(String hour) {
    return AppDateUtils.storageToAppHour(hour);
  }
}
