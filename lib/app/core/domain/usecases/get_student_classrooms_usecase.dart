import '../../data/repositories/get_student_classrooms_repository.dart';
import '../entities/classroom_entity.dart';

class GetStudentClassroomsUsecase {
  final GetStudentClassroomsRepository _classroomRepository;

  GetStudentClassroomsUsecase(this._classroomRepository);

  Future<List<ClassroomEntity>?> call(String studentRegister) async {
    return await _classroomRepository(studentRegister);
  }
}
