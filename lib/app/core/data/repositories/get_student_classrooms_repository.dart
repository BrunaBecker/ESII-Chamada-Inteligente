import '../../domain/entities/classroom_entity.dart';
import '../providers/api/classroom_provider.dart';

class GetStudentClassroomsRepository {
  GetStudentClassroomsRepository({
    required classroomProvider,
  }) : _classroomProvider = classroomProvider;

  final ClassroomProvider _classroomProvider;

  Future<List<ClassroomEntity>?> call(String studentRegister) async {
    return await _classroomProvider.fetchByStudentRegister(
      studentRegister,
    );
  }
}
