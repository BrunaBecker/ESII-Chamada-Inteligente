import 'register_college_id_entity.dart';

abstract class PersonEntity {
  PersonEntity({
    this.id,
    required this.name,
    required this.socialName,
    required this.birthDate,
    this.isActive,
    required this.cpf,
    required this.email,
    required this.register,
  });

  int? id;
  String name;
  String socialName;
  DateTime birthDate;
  bool? isActive;
  String cpf;
  String email;
  RegisterCollegeIdEntity register;
}
