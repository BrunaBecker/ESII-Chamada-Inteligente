import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/classroom_provider.dart';
import '../../core/data/providers/api/event_provider.dart';
import '../../core/data/repositories/create_event_repository.dart';
import '../../core/data/repositories/get_professor_classrooms_repository.dart';
import '../../core/data/repositories/get_professor_events_between_dates_repository.dart';
import '../../core/data/repositories/get_student_events_between_dates_repository.dart';
import '../../core/domain/usecases/create_event_usecase.dart';
import '../../core/domain/usecases/get_professor_classrooms_usecase.dart';
import '../../core/domain/usecases/get_professor_events_between_dates_usecase.dart';
import '../../core/domain/usecases/get_students_event_between_dates_usecase.dart';
import 'calendar_controller.dart';

class CalendarBindings extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<EventProvider>(
      () => EventProvider(
        http: Get.find(),
      ),
    );
    Get.lazyPut<ClassroomProvider>(
      () => ClassroomProvider(
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
    // Get Professor Classrooms
    Get.lazyPut<GetProfessorClassroomsRepository>(
      () => GetProfessorClassroomsRepository(
        classroomProvider: Get.find<ClassroomProvider>(),
      ),
    );
    Get.lazyPut<GetProfessorClassroomsUsecase>(
      () => GetProfessorClassroomsUsecase(
        Get.find<GetProfessorClassroomsRepository>(),
      ),
    );
    // Create Event
    Get.lazyPut<CreateEventRepository>(
      () => CreateEventRepository(
        eventProvider: Get.find<EventProvider>(),
      ),
    );
    Get.lazyPut<CreateEventUsecase>(
      () => CreateEventUsecase(
        Get.find<CreateEventRepository>(),
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
        getProfessorClassrooms: Get.find<GetProfessorClassroomsUsecase>(),
        createEvent: Get.find<CreateEventUsecase>(),
      ),
    );
  }
}
