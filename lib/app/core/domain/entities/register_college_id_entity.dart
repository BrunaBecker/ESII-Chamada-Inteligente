abstract class RegisterCollegeIdEntity {
  RegisterCollegeIdEntity({
    this.id,
    required this.identifier,
    required this.dateStarted,
    this.dateFinished,
    this.isActive = true,
  });

  int? id;
  String identifier;
  DateTime dateStarted;
  DateTime? dateFinished;
  bool isActive;
}
