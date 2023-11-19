import '../../data/repositories/get_student_by_id_repository.dart';
import '../entities/student_entity.dart';

class GetStudentByIdUsecase {
  final GetStudentByIdRepository _getStudentByIdRepository;

  GetStudentByIdUsecase(this._getStudentByIdRepository);

  Future<StudentEntity?> call(int studentId) async {
    return await _getStudentByIdRepository(studentId);
  }
}
