import 'attendance_entity.dart';
import 'location_entity.dart';
import 'professor_entity.dart';
import 'student_entity.dart';

class ClassroomEntity {
  ClassroomEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
    required this.defaultLocation,
    required this.professor,
    required this.students,
    required this.attendances,
  });

  int id;
  String name;
  String code;
  String semester;
  LocationEntity defaultLocation;
  ProfessorEntity professor;
  List<StudentEntity> students;
  List<AttendanceEntity> attendances;
}
