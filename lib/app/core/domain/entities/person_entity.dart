abstract class PersonEntity {
  PersonEntity({
    required this.id,
    required this.name,
    required this.socialName,
    required this.birthDate,
    required this.isActive,
    required this.cpf,
    required this.email,
  });

  int id;
  String name;
  String socialName;
  DateTime birthDate;
  bool isActive;
  String cpf;
  String email;
}
