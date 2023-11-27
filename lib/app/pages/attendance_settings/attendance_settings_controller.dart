import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/location_adapter.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/location_entity.dart';
import '../../core/domain/entities/professor_entity.dart';
import '../../core/domain/entities/virtual_zone_entity.dart';
import '../../core/domain/usecases/create_attendance_usecase.dart';
import '../../core/domain/usecases/create_location_usecase.dart';
import '../../core/domain/usecases/create_virtual_zone_usecase.dart';
import '../../core/domain/usecases/get_classrooms_by_professor_identifier_usecase.dart';
import '../../core/utils/app_date_utils.dart';

class AttendanceSettingsController extends GetxController {
  AttendanceSettingsController({
    required appController,
    required mask,
    required validator,
    required location,
    required getClassroomsByProfessorIdentifier,
    required createAttendance,
    required createVirtualZone,
    required createLocation,
  })  : _appController = appController,
        _mask = mask,
        _validator = validator,
        _location = location,
        _getClassroomsByProfessorIdentifier =
            getClassroomsByProfessorIdentifier,
        _createAttendance = createAttendance,
        _createVirtualZone = createVirtualZone,
        _createLocation = createLocation;

  final AppController _appController;
  final MaskAdapter _mask;
  final ValidatorAdapter _validator;
  final LocationAdapter _location;
  final GetClassroomsByProfessorIdentifierUsecase
      _getClassroomsByProfessorIdentifier;
  final CreateAttendanceUsecase _createAttendance;
  final CreateVirtualZoneUsecase _createVirtualZone;
  final CreateLocationUsecase _createLocation;

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
    _isLoading.value = true;
    super.onReady();

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
    LocationEntity? location;
    VirtualZoneEntity? virtualZone;
    if (selectedClassroom!.defaultLocation != null) {
      virtualZone = VirtualZoneEntity(
        location: selectedClassroom!.defaultLocation!,
      );
      virtualZone = await _createVirtualZone(virtualZone: virtualZone);
    } else {
      try {
        final coordinate = await _location.getCurrentLocation();
        if (coordinate != null) {
          location = LocationEntity(
            title: "Localização para ${selectedClassroom!.courseName}",
            description:
                "Localização criada para ${selectedClassroom!.courseName} em ${AppDateUtils.appDateFormat.format(DateTime.now())}",
            coordinate: coordinate,
            professor: _appController.user as ProfessorEntity,
            classroom: selectedClassroom,
          );
          location = await _createLocation(location: location);
          virtualZone = VirtualZoneEntity(
            location: location,
          );
          virtualZone = await _createVirtualZone(virtualZone: virtualZone);
        }
      } catch (_) {
        return null;
      }
    }

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
