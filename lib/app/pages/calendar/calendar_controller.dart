import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/log_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/event_entity.dart';
import '../../core/domain/usecases/create_event_usecase.dart';
import '../../core/domain/usecases/get_professor_classrooms_usecase.dart';
import '../../core/domain/usecases/get_professor_events_between_dates_usecase.dart';
import '../../core/domain/usecases/get_students_event_between_dates_usecase.dart';
import '../../core/enums/event_status.dart';

class CalendarController extends GetxController {
  CalendarController({
    required appController,
    required validator,
    required GetProfessorEventsBetweenDatesUsecase
        getProfessorEventsBetweenDates,
    required GetStudentEventsBetweenDatesUsecase getStudentEventsBetweenDates,
    required GetProfessorClassroomsUsecase getProfessorClassrooms,
    required CreateEventUsecase createEvent,
  })  : _appController = appController,
        _validator = validator,
        _getProfessorEventsBetweenDates = getProfessorEventsBetweenDates,
        _getStudentEventsBetweenDates = getStudentEventsBetweenDates,
        _getProfessorClassrooms = getProfessorClassrooms,
        _createEvent = createEvent;

  final AppController _appController;
  final ValidatorAdapter _validator;
  final GetProfessorEventsBetweenDatesUsecase _getProfessorEventsBetweenDates;
  final GetStudentEventsBetweenDatesUsecase _getStudentEventsBetweenDates;
  final GetProfessorClassroomsUsecase _getProfessorClassrooms;
  final CreateEventUsecase _createEvent;

  final _isLoading = true.obs;
  final _formKey = GlobalKey<FormState>();
  final _professorClassrooms = <ClassroomEntity>[].obs;
  final _selectedClassroom = Rx<ClassroomEntity?>(null);
  final _selectedEventStatus = Rx<EventStatus?>(null);
  final _commentController = TextEditingController();
  final _selectedDate = Rx<DateTime?>(null);
  final _events = <EventEntity>[].obs;
  final _selectedDayEvents = <EventEntity>[].obs;
  bool skipDate = true;

  AppController get appController => _appController;
  ValidatorAdapter get validator => _validator;

  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  List<ClassroomEntity> get professorClassrooms => _professorClassrooms;
  ClassroomEntity? get selectedClassroom => _selectedClassroom.value;
  EventStatus? get selectedEventStatus => _selectedEventStatus.value;
  TextEditingController get commentController => _commentController;
  DateTime? get selectedDate => _selectedDate.value;
  List<EventEntity> get events => _events;
  List<EventEntity> get selectedDayEvents => _selectedDayEvents;

  set selectedClassroom(ClassroomEntity? value) =>
      _selectedClassroom.value = value;
  set selectedEventStatus(EventStatus? value) =>
      _selectedEventStatus.value = value;

  @override
  void onReady() async {
    _isLoading.value = true;
    super.onReady();

    if (_appController.user?.id == null) return;
    await fetchEvents(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now().add(const Duration(days: 30)),
    );
    await fetchProfessorClassrooms();

    _isLoading.value = false;
  }

  Future<bool> saveEvent() async {
    if (_formKey.currentState?.validate() != true) return false;

    try {
      appLog(selectedClassroom.toString());
      appLog(selectedEventStatus.toString());
      appLog(selectedDate.toString());
      appLog(commentController.text);
      appLog("Creating");
      final newEvent = await _createEvent(
        event: EventEntity(
          name:
              "${selectedClassroom!.courseName} - ${selectedClassroom!.className}",
          date: selectedDate!,
          description: commentController.text,
          classroom: selectedClassroom!,
          status: selectedEventStatus!,
        ),
      );
      appLog("Created");
      _events.add(newEvent);
      _selectedClassroom.value = null;
      _selectedEventStatus.value = null;
      commentController.clear();
      update();
      return true;
    } catch (_) {
      return false;
    }
  }

  void changeDate(DateTime? date) {
    _selectedDate.value = date;
    if (date != null) {
      _selectedDayEvents.clear();
      _selectedDayEvents.addAll(
        events.where(
          (event) {
            return event.date.day == date.day &&
                event.date.month == date.month &&
                event.date.year == date.year;
          },
        ),
      );
    }
  }

  Future<void> fetchEvents({
    required DateTime start,
    required DateTime end,
  }) async {
    events.clear();
    events.addAll(
      _appController.isProfessor
          ? await _getProfessorEventsBetweenDates(
              id: _appController.user!.id!,
              start: start,
              end: end,
            )
          : await _getStudentEventsBetweenDates(
              id: _appController.user!.id!,
              start: start,
              end: end,
            ),
    );
    update();
  }

  Future<void> fetchProfessorClassrooms() async {
    if (_appController.isProfessor) {
      _professorClassrooms.clear();
      try {
        final classroomsResult = await _getProfessorClassrooms(
            _appController.user!.register.identifier) as List<ClassroomEntity>;
        _professorClassrooms.addAll(classroomsResult);
      } catch (_) {}
    }
    update();
  }
}
