import '../../../adapters/http_adapter.dart';
import '../../dtos/student_dto.dart';
import '../base_provider.dart';

class AuthProvider extends BaseProvider {
  Http http;

  AuthProvider({required this.http});

  Future<StudentDto?> loginStudent(
      String studentRegister, String password) async {
    try {
      final response = await http.post(
        '/auth/login/student?identifier=$studentRegister&password=$password',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<StudentDto?> loginProfessor(
      String professorRegister, String password) async {
    try {
      final response = await http.post(
        '/auth/login/professor?identifier=$professorRegister&password=$password',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
