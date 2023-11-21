import '../../data/repositories/get_professor_classrooms_repository.dart';
import '../entities/classroom_entity.dart';

class GetProfessorClassroomsUsecase {
  final GetProfessorClassroomsRepository _classroomRepository;

  GetProfessorClassroomsUsecase(this._classroomRepository);

  Future<List<ClassroomEntity>?> call(String professorRegister) async {
    return await _classroomRepository(professorRegister);
  }
}
