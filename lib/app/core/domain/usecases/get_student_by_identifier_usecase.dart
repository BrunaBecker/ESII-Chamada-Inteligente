import '../../data/repositories/get_student_by_identifier_repository.dart';
import '../entities/student_entity.dart';

class GetStudentByIdentifierUsecase {
  final GetStudentByIdentifierRepository _getStudentByIdentifierRepository;

  GetStudentByIdentifierUsecase(this._getStudentByIdentifierRepository);

  Future<StudentEntity> call(String studentIdentifier) async {
    return await _getStudentByIdentifierRepository(studentIdentifier);
  }
}
