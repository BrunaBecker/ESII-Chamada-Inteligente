import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/http_adapter.dart';
import '../../core/data/providers/api/professor_provider.dart';
import '../../core/data/providers/api/student_provider.dart';
import '../../core/data/repositories/get_professor_by_id_repository.dart';
import '../../core/data/repositories/get_student_by_id_repository.dart';
import '../../core/domain/usecases/get_professor_by_id_usecase.dart';
import '../../core/domain/usecases/get_student_by_id_usecase.dart';
import 'profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut(
      () => ProfessorProvider(
        http: Get.find<Http>(),
      ),
    );
    Get.lazyPut(
      () => StudentProvider(
        http: Get.find<Http>(),
      ),
    );

    // Get professor by id
    Get.lazyPut(
      () => GetProfessorByIdRepository(
        professorProvider: Get.find<ProfessorProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetProfessorByIdUsecase(
        Get.find<GetProfessorByIdRepository>(),
      ),
    );

    // Get student by id
    Get.lazyPut(
      () => GetStudentByIdRepository(
        studentProvider: Get.find<StudentProvider>(),
      ),
    );
    Get.lazyPut(
      () => GetStudentByIdUsecase(
        Get.find<GetStudentByIdRepository>(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => ProfileController(
        appController: Get.find<AppController>(),
        getProfessorById: Get.find<GetProfessorByIdUsecase>(),
        getStudentById: Get.find<GetStudentByIdUsecase>(),
      ),
    );
  }
}
