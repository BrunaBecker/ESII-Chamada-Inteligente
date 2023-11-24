import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/event_provider.dart';
import '../../core/data/repositories/get_professor_events_between_dates_repository.dart';
import '../../core/data/repositories/get_student_events_between_dates_repository.dart';
import '../../core/domain/usecases/get_professor_events_between_dates_usecase.dart';
import '../../core/domain/usecases/get_students_event_between_dates_usecase.dart';
import 'calendar_controller.dart';

class CalendarBindings extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<EventProvider>(
      () => EventProvider(
        http: Get.find(),
      ),
    );

    // Get Student Events Between Dates
    Get.lazyPut<GetStudentEventsBetweenDatesRepository>(
      () => GetStudentEventsBetweenDatesRepository(
        eventProvider: Get.find<EventProvider>(),
      ),
    );
    Get.lazyPut<GetStudentEventsBetweenDatesUsecase>(
      () => GetStudentEventsBetweenDatesUsecase(
        Get.find<GetStudentEventsBetweenDatesRepository>(),
      ),
    );

    // Get Professor Events Between Dates
    Get.lazyPut<GetProfessorEventsBetweenDatesRepository>(
      () => GetProfessorEventsBetweenDatesRepository(
        eventProvider: Get.find<EventProvider>(),
      ),
    );
    Get.lazyPut<GetProfessorEventsBetweenDatesUsecase>(
      () => GetProfessorEventsBetweenDatesUsecase(
        Get.find<GetProfessorEventsBetweenDatesRepository>(),
      ),
    );

    // Controller
    Get.lazyPut<CalendarController>(
      () => CalendarController(
        appController: Get.find<AppController>(),
        validator: Get.find<ValidatorAdapter>(),
        getProfessorEventsBetweenDates:
            Get.find<GetProfessorEventsBetweenDatesUsecase>(),
        getStudentEventsBetweenDates:
            Get.find<GetStudentEventsBetweenDatesUsecase>(),
      ),
    );
  }
}
