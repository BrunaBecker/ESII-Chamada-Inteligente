import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/adapters/storage_adapter.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/domain/usecases/get_professor_by_id_usecase.dart';
import '../../core/domain/usecases/get_student_by_id_usecase.dart';

class ProfileController extends GetxController {
  ProfileController({
    required appController,
    required StorageAdapter storage,
    required getProfessorById,
    required getStudentById,
  })  : _appController = appController,
        _storage = storage,
        _getProfessorById = getProfessorById,
        _getStudentById = getStudentById;

  final AppController _appController;
  final StorageAdapter _storage;
  final GetProfessorByIdUsecase _getProfessorById;
  final GetStudentByIdUsecase _getStudentById;

  final _isLoading = true.obs;
  final _user = Rx<PersonEntity?>(null);

  bool get isLoading => _isLoading.value;
  PersonEntity? get user => _user.value;
  bool get isProfessor => _appController.userType == UserType.professor;
  String get profileImage => _appController.userProfileImage;

  @override
  void onInit() async {
    super.onInit();

    try {
      _user.value = isProfessor
          ? await _getProfessorById(_appController.user!.id!)
          : await _getStudentById(_appController.user!.id!);
    } catch (_) {
      _user.value = null;
    }

    _isLoading.value = false;
  }

  void logout() {
    _isLoading.value = true;
    _appController.user = null;
    _appController.userType = null;
    _storage.deleteAuthData();
  }
}
