import '../../data/repositories/login_student_repository.dart';
import '../entities/student_entity.dart';

class LoginStudentUsecase {
  final LoginStudentRepository _loginStudentRepository;

  LoginStudentUsecase(this._loginStudentRepository);

  Future<StudentEntity?> call(String studentRegister, String password) async {
    return await _loginStudentRepository(studentRegister, password);
  }
}
