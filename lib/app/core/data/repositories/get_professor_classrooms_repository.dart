import '../../domain/entities/classroom_entity.dart';
import '../providers/api/classroom_provider.dart';

class GetProfessorClassroomsRepository {
  GetProfessorClassroomsRepository({
    required classroomProvider,
  }) : _classroomProvider = classroomProvider;

  final ClassroomProvider _classroomProvider;

  Future<List<ClassroomEntity>?> call(String professorRegister) async {
    return await _classroomProvider.fetchByProfessorRegister(
      professorRegister,
    );
  }
}
