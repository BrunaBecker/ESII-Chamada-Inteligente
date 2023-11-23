import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/domain/entities/event_entity.dart';
import '../../core/domain/usecases/get_professor_events_between_dates_usecase.dart';
import '../../core/domain/usecases/get_students_event_between_dates_usecase.dart';

class CalendarController extends GetxController {
  CalendarController({
    required appController,
    required validator,
    required GetProfessorEventsBetweenDatesUsecase
        getProfessorEventsBetweenDates,
    required GetStudentEventsBetweenDatesUsecase getStudentEventsBetweenDates,
  })  : _appController = appController,
        _validator = validator,
        _getProfessorEventsBetweenDates = getProfessorEventsBetweenDates,
        _getStudentEventsBetweenDates = getStudentEventsBetweenDates;

  final AppController _appController;
  final ValidatorAdapter _validator;
  final GetProfessorEventsBetweenDatesUsecase _getProfessorEventsBetweenDates;
  final GetStudentEventsBetweenDatesUsecase _getStudentEventsBetweenDates;

  final _isLoading = true.obs;
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final _eventController = TextEditingController();
  final _commentController = TextEditingController();
  final _selectedDate = Rx<DateTime?>(null);
  final _events = <EventEntity>[].obs;
  final _selectedDayEvents = <EventEntity>[].obs;
  bool skipDate = true;

  AppController get appController => _appController;
  ValidatorAdapter get validator => _validator;

  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get classNameController => _classNameController;
  TextEditingController get eventController => _eventController;
  TextEditingController get commentController => _commentController;
  DateTime? get selectedDate => _selectedDate.value;
  List<EventEntity> get events => _events;
  List<EventEntity> get selectedDayEvents => _selectedDayEvents;

  @override
  void onReady() async {
    _isLoading.value = true;
    super.onReady();

    if (_appController.user?.id == null) return;
    await fetchEvents(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now().add(const Duration(days: 30)),
    );

    _isLoading.value = false;
  }

  void saveEvent() {
    // TODO: save event
    classNameController.clear();
    eventController.clear();
    commentController.clear();
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
}
