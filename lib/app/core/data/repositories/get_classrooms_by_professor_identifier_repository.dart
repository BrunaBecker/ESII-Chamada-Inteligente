import '../../domain/entities/classroom_entity.dart';
import '../providers/api/classroom_provider.dart';

class GetClassroomsByProfessorIdentifierRepository {
  GetClassroomsByProfessorIdentifierRepository({
    required classroomProvider,
  }) : _classroomProvider = classroomProvider;

  final ClassroomProvider _classroomProvider;

  Future<List<ClassroomEntity>> call(String professorIdentifier) async {
    return await _classroomProvider.fetchByProfessorRegister(
      professorIdentifier,
    );
  }
}
