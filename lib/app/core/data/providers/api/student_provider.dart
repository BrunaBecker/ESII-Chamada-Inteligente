import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/student_entity.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/student_dto.dart';
import '../base_provider.dart';

class StudentProvider extends BaseProvider {
  Http http;

  StudentProvider({required this.http});

  Future<StudentDto?> fetchStudentByIdentifier(Long studentIdentifier) async {
    try {
      final response = await http.get(
        '/student/byIdentifier/$studentIdentifier',
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

  Future<StudentDto?> fetchStudentById(Long id) async {
    try {
      final response = await http.get(
        '/student/$id',
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

  Future<StudentDto?> createStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.post(
        '/student',
        body: studentDto.toJson(),
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

  Future<StudentDto?> updateStudent(StudentEntity studentEntity) async {
    StudentDto studentDto = StudentDto.fromEntity(studentEntity);
    try {
      final response = await http.put(
        '/student',
        body: studentDto.toJson(),
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

  Future<StudentDto?> addClassroom(
      Long studentIdentifier, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);
    try {
      final response = await http.put(
        '/$studentIdentifier/class',
        body: classroomDto.toJson(),
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

  Future<StudentDto?> addClassroomByClassroomId(
      Long studentIdenfitifer, Long classroomId) async {
    try {
      final response = await http.put(
        '/$studentIdenfitifer/class/$classroomId',
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
