import 'professor_entity.dart';
import 'student_entity.dart';

class ClassroomEntity {
  ClassroomEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
    required this.startHour,
    required this.endHour,
    required this.professor,
    this.students,
  });

  int id;
  String name;
  String code;
  String semester;
  DateTime startHour;
  DateTime endHour;
  ProfessorEntity professor;
  List<StudentEntity>? students;
}
