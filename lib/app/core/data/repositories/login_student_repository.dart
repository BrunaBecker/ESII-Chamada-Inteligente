import '../dtos/student_dto.dart';
import '../providers/api/auth_provider.dart';

class LoginStudentRepository {
  LoginStudentRepository({
    required authProvider,
  }) : _authProvider = authProvider;

  final AuthProvider _authProvider;

  Future<StudentDto?> call(String studentRegister, String password) async {
    return await _authProvider.loginStudent(studentRegister, password);
  }
}
