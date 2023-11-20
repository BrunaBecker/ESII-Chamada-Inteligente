import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/professor_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/professor_dto.dart';
import '../base_provider.dart';

class ProfessorProvider extends BaseProvider {
  Http http;

  ProfessorProvider({required this.http});

  Future<ProfessorDto?> create(ProfessorEntity professorEntity) async {
    ProfessorDto professorDto = ProfessorDto.fromEntity(professorEntity);
    try {
      final response = await http.post(
        '/professor',
        body: professorDto.toJson(),
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
      return null;
    }
  }

  Future<ProfessorEntity?> update(ProfessorEntity professorEntity) async {
    ProfessorDto professorDto = ProfessorDto.fromEntity(professorEntity);

    try {
      final response = await http.put(
        '/professor',
        body: professorDto.toJson(),
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
      return null;
    }
  }

  Future<ProfessorEntity?> addClassroom(
      int professorRegister, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put(
        '/professor/$professorRegister/class',
        body: classroomDto.toJson(),
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
      return null;
    }
  }

  Future<ProfessorEntity?> fetchById(int id) async {
    try {
      final response = await http.get(
        '/professor/$id',
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
      return null;
    }
  }

  Future<ProfessorDto?> fetchByRegister(int idenfitifer) async {
    try {
      final response = await http.get(
        '/professor/byIdentifier/$idenfitifer',
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
      return null;
    }
  }

  Future<ProfessorDto?> fetchByClassroomCode(String classroomCode) async {
    try {
      final response = await http.get(
        '/professor/byClassroomCode/$classroomCode',
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
      return null;
    }
  }
}
