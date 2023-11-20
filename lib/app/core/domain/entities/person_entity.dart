import 'picture_entity.dart';
import 'register_college_id_entity.dart';
import 'setting_entity.dart';

abstract class PersonEntity {
  PersonEntity({
    this.id,
    required this.name,
    required this.socialName,
    required this.birthDate,
    this.isActive = true,
    required this.cpf,
    required this.email,
    required this.password,
    this.setting,
    this.profileImage,
    required this.register,
  });

  int? id;
  String name;
  String socialName;
  DateTime birthDate;
  bool isActive;
  String cpf;
  String email;
  String password;
  SettingEntity? setting;
  PictureEntity? profileImage;
  RegisterCollegeIdEntity register;
}
