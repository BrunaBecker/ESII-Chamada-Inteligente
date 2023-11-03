import 'setting_entity.dart';

abstract class PersonEntity {
  PersonEntity({
    required this.id,
    required this.name,
    required this.socialName,
    required this.birthDate,
    required this.isActive,
    required this.cpf,
    required this.email,
    required this.password,
    required this.setting,
  });

  int id;
  String name;
  String socialName;
  DateTime birthDate;
  bool isActive;
  String cpf;
  String email;
  String password;
  SettingEntity setting;
}
