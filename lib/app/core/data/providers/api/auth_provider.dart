import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/professor_entity.dart';
import '../../../domain/entities/student_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/professor_dto.dart';
import '../../dtos/student_dto.dart';
import '../base_provider.dart';

class AuthProvider extends BaseProvider {
  Http http;

  AuthProvider({required this.http});

  Future<StudentEntity?> loginStudent(
      String studentRegister, String password) async {
    try {
      final response = await http.get(
        '/auth/login/student',
        query: {
          'identifier': studentRegister,
          'password': password,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StudentDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity?> loginProfessor(
      String professorRegister, String password) async {
    try {
      final response = await http.get(
        '/auth/login/professor',
        query: {
          'identifier': professorRegister,
          'password': password,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }
}
