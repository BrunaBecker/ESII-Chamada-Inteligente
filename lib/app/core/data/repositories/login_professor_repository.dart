import '../dtos/professor_dto.dart';
import '../providers/api/auth_provider.dart';

class LoginProfessorRepository {
  LoginProfessorRepository({
    required authProvider,
  }) : _authProvider = authProvider;

  final AuthProvider _authProvider;

  Future<ProfessorDto?> call(String professorRegister, String password) async {
    return await _authProvider.loginProfessor(professorRegister, password)
        as ProfessorDto?;
  }
}
