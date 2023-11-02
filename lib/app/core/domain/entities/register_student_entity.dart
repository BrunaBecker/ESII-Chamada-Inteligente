import 'register_college_id_entity.dart';
import 'student_entity.dart';

class RegisterStudentEntity extends RegisterCollegeIdEntity {
  RegisterStudentEntity({
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
    required this.id,
    required this.student,
  });

  int id;
  StudentEntity student;
}
