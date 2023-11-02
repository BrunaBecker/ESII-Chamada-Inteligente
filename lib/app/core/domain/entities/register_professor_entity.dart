import 'professor_entity.dart';
import 'register_college_id_entity.dart';

class RegisterProfessorEntity extends RegisterCollegeIdEntity {
  RegisterProfessorEntity({
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
    required this.id,
    required this.professor,
  });

  int id;
  ProfessorEntity professor;
}
