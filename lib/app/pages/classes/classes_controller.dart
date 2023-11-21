import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../core/domain/entities/attendance_entity.dart';
import '../../core/domain/entities/classroom_entity.dart';
import '../../core/domain/entities/person_entity.dart';
import '../../core/domain/usecases/get_professor_classrooms_usecase.dart';
import '../../core/domain/usecases/get_student_classrooms_usecase.dart';

class ClassesController extends GetxController {
  ClassesController({
    required appController,
    required getProfessorClassrooms,
    required getStudentClassrooms,
  })  : _appController = appController,
        _getProfessorClassrooms = getProfessorClassrooms,
        _getStudentClassrooms = getStudentClassrooms;

  final AppController _appController;
  final GetProfessorClassroomsUsecase _getProfessorClassrooms;
  final GetStudentClassroomsUsecase _getStudentClassrooms;

  final _isLoading = true.obs;
  final _classrooms = <ClassroomEntity>[].obs;
  late final AttendanceEntity? _currentAttendance;

  bool get isLoading => _isLoading.value;
  List<ClassroomEntity> get classrooms => _classrooms;
  AttendanceEntity? get currentAttendance => _currentAttendance;
  UserType? get userType => Get.find<AppController>().userType;
  bool get isProfessor => userType == UserType.professor;
  PersonEntity get user => _appController.user!;
  String get userProfileImage => _appController.userProfileImage;

  @override
  void onReady() async {
    _isLoading.value = true;
    await fetch();

    _isLoading.value = false;
    super.onReady();
  }

  Future<void> fetch() async {
    // TODO: get user happening attendance
    _currentAttendance = null;

    _classrooms.clear();
    try {
      final classroomsResult = _appController.isProfessor
          ? await _getProfessorClassrooms(
              user.register.identifier,
            )
          : await _getStudentClassrooms(
              user.register.identifier,
            );
      if (classroomsResult != null) {
        _classrooms.addAll(classroomsResult);
      }
    } catch (_) {}
  }
}
