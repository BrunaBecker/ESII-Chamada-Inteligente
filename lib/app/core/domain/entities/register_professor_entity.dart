import 'register_college_id_entity.dart';

class RegisterProfessorEntity extends RegisterCollegeIdEntity {
  RegisterProfessorEntity({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
  });
}
