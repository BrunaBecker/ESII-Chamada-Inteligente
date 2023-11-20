import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/classroom_dto.dart';
import '../base_provider.dart';

class ClassroomProvider extends BaseProvider {
  Http http;

  ClassroomProvider({required this.http});

  Future<ClassroomEntity?> create(ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.post(
        '/classroom',
        body: classroomDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<ClassroomEntity?> update(ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put(
        '/classroom',
        body: classroomDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ClassroomDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<ClassroomEntity>?> fetchByProfessorRegister(
      int professorRegister) async {
    try {
      final response = await http.get(
        '/classroom/professor/$professorRegister',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final classrooms = response.data
          .map<ClassroomDto>(
            (classroom) => ClassroomDto.fromMap(classroom),
          )
          .toList();

      return classrooms;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<ClassroomEntity>?> fetchByStudentRegister(
      int studentRegister) async {
    try {
      final response = await http.get(
        '/classroom/student/$studentRegister',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final classrooms = response.data
          .map<ClassroomDto>(
            (classroom) => ClassroomDto.fromMap(classroom),
          )
          .toList();

      return classrooms;
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
