import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/adapters/validator_adapter.dart';

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

  ValidatorAdapter get validator => _validator;
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get classNameController => _classNameController;
  TextEditingController get eventController => _eventController;
  TextEditingController get commentController => _commentController;

  @override
  void onReady() async {
    super.onReady();

    _isLoading.value = false;
  }

  void saveEvent() {
    // TODO: save event
    classNameController.clear();
    eventController.clear();
    commentController.clear();
  }
}
