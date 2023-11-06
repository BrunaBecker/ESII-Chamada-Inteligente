import 'register_college_id_entity.dart';

class RegisterStudentEntity extends RegisterCollegeIdEntity {
  RegisterStudentEntity({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
    required super.person,
  });
}
