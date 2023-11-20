import 'person_entity.dart';

class ProfessorEntity extends PersonEntity {
  ProfessorEntity({
    super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    super.isActive = true,
    required super.cpf,
    required super.email,
    required super.password,
    super.setting,
    super.profileImage,
    required super.register,
  });
}
