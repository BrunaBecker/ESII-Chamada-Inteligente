import 'dart:ffi';

import '../../adapters/http_adapter.dart';
import '../../domain/entities/classroom_entity.dart';
import '../../domain/entities/professor_entity.dart';
import '../dtos/classroom_dto.dart';
import '../dtos/professor_dto.dart';
import 'base_provider.dart';

class ProfessorProvider extends BaseProvider {
  Http http;

  ProfessorProvider({required this.http});

  Future<ProfessorDto?> fetchProfessor(Long id) async {
    try {
      final response = await http.get(
        '/Professors/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } catch (e) {
      logError(e.toString());
    }

    return null;
  }

  Future<List<ProfessorDto>> fetchAllProfessors(Long id) async {
    try {
      final response = await http.get(
        '/Professors',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final professors = response.data
          .map<ProfessorDto>(
            (professor) => ProfessorDto.fromJson(professor),
          )
          .toList();

      return professors;
    } catch (e) {
      logError(e.toString());
    }

    return [];
  }

  Future<void> updateProfessor(ProfessorEntity professor) async {
    ProfessorDto professorDto = ProfessorDto.fromEntity(professor);

    try {
      final response = await http.put(
        '/Professors',
        body: professorDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<void> addClassroom(Long id, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put('/Professors/$id/class', body: {
        "Classroom": classroomDto.toJson(),
      });

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
  }
}
