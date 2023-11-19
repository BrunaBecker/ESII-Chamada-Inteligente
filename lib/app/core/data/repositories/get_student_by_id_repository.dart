import '../dtos/student_dto.dart';
import '../providers/api/student_provider.dart';

class GetStudentByIdRepository {
  GetStudentByIdRepository({
    required studentProvider,
  }) : _studentProvider = studentProvider;

  final StudentProvider _studentProvider;

  Future<StudentDto?> call(int studentId) async {
    return await _studentProvider.fetchById(studentId) as StudentDto?;
  }
}
