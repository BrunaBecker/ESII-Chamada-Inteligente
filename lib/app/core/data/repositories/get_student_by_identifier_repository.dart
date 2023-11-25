import '../../domain/entities/student_entity.dart';
import '../providers/api/student_provider.dart';

class GetStudentByIdentifierRepository {
  GetStudentByIdentifierRepository({
    required studentProvider,
  }) : _studentProvider = studentProvider;

  final StudentProvider _studentProvider;

  Future<StudentEntity> call(String studentIdentifier) async {
    return await _studentProvider.fetchByIdentifier(studentIdentifier);
  }
}
