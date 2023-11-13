import '../../enums/user_types.dart';
import 'person_entity.dart';
import 'picture_entity.dart';
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
    required super.register,
    this.setting,
    required this.profileImage,
  });

  SettingEntity? setting;
  PictureEntity? profileImage;
  String password;
  final UserTypes type = UserTypes.professor;
}
