import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/professor_entity.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/professor_dto.dart';
import '../base_provider.dart';

class ProfessorProvider extends BaseProvider {
  Http http;

  ProfessorProvider({required this.http});

  Future<ProfessorEntity?> fetchProfessorById(Long id) async {
    try {
      final response = await http.get(
        '/professor/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<ProfessorDto?> fetchProfessorByIdentifier(Long idenfitifer) async {
    try {
      final response = await http.get(
        '/professor/byIdentifier/$idenfitifer',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<ProfessorDto?> createProfessor(ProfessorEntity professorEntity) async {
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

      return ProfessorDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  /// NÃO USAR, VAI CRASHAR O SERVIDOR E O APP
  Future<List<ProfessorDto>?> fetchAllProfessors(Long id) async {
    try {
      final response = await http.get(
        '/professor',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final professor = response.data
          .map<ProfessorDto>(
            (professor) => ProfessorDto.fromJson(professor),
          )
          .toList();

      return professor;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<ProfessorEntity?> updateProfessor(
      ProfessorEntity professorEntity) async {
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

      return ProfessorDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<ProfessorEntity?> addClassroom(
      Long id, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put('/professor/$id/class', body: {
        "Classroom": classroomDto.toJson(),
      });

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
