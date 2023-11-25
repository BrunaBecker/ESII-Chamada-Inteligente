import '../../data/repositories/get_classrooms_by_professor_identifier_repository.dart';
import '../entities/classroom_entity.dart';

class GetClassroomsByProfessorIdentifierUsecase {
  final GetClassroomsByProfessorIdentifierRepository
      _getClassroomByProfessorIdentifier;

  GetClassroomsByProfessorIdentifierUsecase(
      this._getClassroomByProfessorIdentifier);

  Future<List<ClassroomEntity>> call(String professorIdentifier) async {
    return await _getClassroomByProfessorIdentifier(professorIdentifier);
  }
}
