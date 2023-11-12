import 'person_entity.dart';
import 'picture_entity.dart';
import 'register_college_id_entity.dart';
import 'setting_entity.dart';

class ProfessorEntity extends PersonEntity {
  ProfessorEntity({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required this.password,
    this.siape,
    this.setting,
    required this.profileImage,
  });

  RegisterCollegeIdEntity? siape;
  SettingEntity? setting;
  PictureEntity? profileImage;
  String password;
}
