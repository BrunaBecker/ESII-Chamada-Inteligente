import '../../data/repositories/login_professor_repository.dart';
import '../entities/professor_entity.dart';

class LoginProfessorUsecase {
  final LoginProfessorRepository _loginProfessorRepository;

  LoginProfessorUsecase(this._loginProfessorRepository);

  Future<ProfessorEntity?> call(
      String professorRegister, String password) async {
    return await _loginProfessorRepository(professorRegister, password);
  }
}
