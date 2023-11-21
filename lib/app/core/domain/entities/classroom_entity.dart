import 'event_entity.dart';
import 'location_entity.dart';
import 'professor_entity.dart';
import 'student_entity.dart';

class ClassroomEntity {
  ClassroomEntity({
    this.id,
    required this.courseName,
    required this.className,
    required this.code,
    required this.semester,
    required this.startHour,
    required this.endHour,
    required this.professor,
    this.defaultLocation,
    this.events,
    this.students,
  });

  int? id;
  String courseName;
  String className;
  String code;
  String semester;
  String startHour;
  String endHour;
  ProfessorEntity professor;
  LocationEntity? defaultLocation;
  List<EventEntity>? events;
  List<StudentEntity>? students;
}
