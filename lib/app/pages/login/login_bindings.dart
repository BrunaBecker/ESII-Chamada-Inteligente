import 'package:get/get.dart';

import '../../core/adapters/http_adapter.dart';
import '../../core/adapters/mask_adapter.dart';
import '../../core/adapters/validator_adapter.dart';
import '../../core/data/providers/api/auth_provider.dart';
import '../../core/data/repositories/login_professor_repository.dart';
import '../../core/data/repositories/login_student_repository.dart';
import '../../core/domain/usecases/login_professor_usecase.dart';
import '../../core/domain/usecases/login_student_usecase.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(
        http: Get.find<Http>(),
      ),
    );

    // Repositories
    Get.lazyPut<LoginProfessorRepository>(
      () => LoginProfessorRepository(
        authProvider: Get.find<AuthProvider>(),
      ),
    );
    Get.lazyPut<LoginStudentRepository>(
      () => LoginStudentRepository(
        authProvider: Get.find<AuthProvider>(),
      ),
    );

    // Usecases
    Get.lazyPut(
      () => LoginProfessorUsecase(
        Get.find<LoginProfessorRepository>(),
      ),
    );
    Get.lazyPut(
      () => LoginStudentUsecase(
        Get.find<LoginStudentRepository>(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => LoginController(
        mask: Get.find<MaskAdapter>(),
        validator: Get.find<ValidatorAdapter>(),
        loginProfessor: Get.find<LoginProfessorUsecase>(),
        loginStudent: Get.find<LoginStudentUsecase>(),
      ),
    );
  }
}
