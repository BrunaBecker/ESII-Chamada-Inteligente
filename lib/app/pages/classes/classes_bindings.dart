import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/data/providers/api/classroom_provider.dart';
import '../../core/data/repositories/get_professor_classrooms_repository.dart';
import '../../core/data/repositories/get_student_classrooms_repository.dart';
import '../../core/domain/usecases/get_professor_classrooms_usecase.dart';
import '../../core/domain/usecases/get_student_classrooms_usecase.dart';
import 'classes_controller.dart';

class ClassesBindings extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<ClassroomProvider>(
      () => ClassroomProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get Professor Classrooms
    Get.lazyPut(
      () => GetProfessorClassroomsRepository(
        classroomProvider: Get.find<ClassroomProvider>(),
      ),
    );
    Get.lazyPut<GetProfessorClassroomsUsecase>(
      () => GetProfessorClassroomsUsecase(
        Get.find<GetProfessorClassroomsRepository>(),
      ),
    );

    // Get Student Classrooms
    Get.lazyPut(
      () => GetStudentClassroomsRepository(
        classroomProvider: Get.find<ClassroomProvider>(),
      ),
    );
    Get.lazyPut<GetStudentClassroomsUsecase>(
      () => GetStudentClassroomsUsecase(
        Get.find<GetStudentClassroomsRepository>(),
      ),
    );

    // Controller
    Get.lazyPut<ClassesController>(
      () => ClassesController(
        appController: Get.find<AppController>(),
        getProfessorClassrooms: Get.find<GetProfessorClassroomsUsecase>(),
        getStudentClassrooms: Get.find<GetStudentClassroomsUsecase>(),
      ),
    );
  }
}
