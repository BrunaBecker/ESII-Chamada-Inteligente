import 'person_entity.dart';
import 'picture_entity.dart';
import 'register_college_id_entity.dart';
import 'setting_entity.dart';

class StudentEntity extends PersonEntity {
  StudentEntity({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required this.password,
    required this.register,
    required this.setting,
    required this.profileImage,
  });

  String password;
  RegisterCollegeIdEntity register;
  SettingEntity setting;
  PictureEntity profileImage;
}
