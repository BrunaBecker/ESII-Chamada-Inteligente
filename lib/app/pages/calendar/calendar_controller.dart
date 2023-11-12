import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/validator_adapter.dart';
import '../../core/enums/event_status.dart';
import '../../core/theme/app_colors.dart';

class CalendarController extends GetxController {
  CalendarController({
    required validator,
  }) : _validator = validator;

  final ValidatorAdapter _validator;

  final _isLoading = true.obs;
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final _eventController = TextEditingController();
  final _commentController = TextEditingController();
  final _selectedDate = Rx<DateTime?>(null);
  final _events = <Map<String, dynamic>>[].obs;
  final _selectedDayEvents = <Map<String, dynamic>>[].obs;

  ValidatorAdapter get validator => _validator;
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get classNameController => _classNameController;
  TextEditingController get eventController => _eventController;
  TextEditingController get commentController => _commentController;
  DateTime? get selectedDate => _selectedDate.value;
  List<Map<String, dynamic>> get events => _events;
  List<Map<String, dynamic>> get selectedDayEvents => _selectedDayEvents;

  @override
  void onReady() async {
    super.onReady();
    // TODO: get events
    events.addAll(
      [
        {
          "startTime": DateTime.now().add(const Duration(hours: -6)),
          "endTime": DateTime.now().add(const Duration(hours: -4)),
          "class": "Engenharia de Software II",
          "status": EventStatus.classNormal,
          "color": AppColors.green1,
          "code": "TCC00001",
          "description": "Aula 5 - Git",
        },
        {
          "startTime": DateTime.now().add(const Duration(hours: -6)),
          "endTime": DateTime.now().add(const Duration(hours: -4)),
          "class": "Redes de Computadores II",
          "status": EventStatus.classCancelled,
          "color": AppColors.redDarker,
          "code": "TCC00002",
          "description": "Não teremos aula porque terei que ir ao médico.",
        },
        {
          "startTime": DateTime.now().add(const Duration(hours: -6)),
          "endTime": DateTime.now().add(const Duration(hours: -4)),
          "class": "Lógica Para Ciência da Computação",
          "status": EventStatus.classNormalRecurrent,
          "color": AppColors.orange,
          "code": "TCC00003",
          "description": "Aula 9 - Árvore de Refutação",
        },
      ],
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
            return event["startTime"].day == date.day && event["startTime"].month == date.month && event["startTime"].year == date.year;
          },
        ),
      );
    }
    update();
  }
}
