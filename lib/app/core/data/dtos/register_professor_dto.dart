import 'dart:convert';

import '../../domain/entities/register_professor_entity.dart';
import '../../utils/app_date_utils.dart';

class RegisterProfessorDto extends RegisterProfessorEntity {
  RegisterProfessorDto({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
  });

  factory RegisterProfessorDto.fromEntity(RegisterProfessorEntity entity) {
    return RegisterProfessorDto(
      id: entity.id,
      identifier: entity.identifier,
      dateStarted: entity.dateStarted,
      dateFinished: entity.dateFinished,
      isActive: entity.isActive,
    );
  }

  factory RegisterProfessorDto.fromMap(Map<String, dynamic> map) {
    return RegisterProfessorDto(
      id: map["id"],
      identifier: map["identifier"],
      dateStarted: AppDateUtils.storageDateFormat.parse(map["dateStarted"]),
      dateFinished: AppDateUtils.storageDateFormat.parse(map["dateFinished"]),
      isActive: map["isActive"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "identifier": identifier,
      "dateStarted": AppDateUtils.storageDateFormat.format(dateStarted),
      "dateFinished": AppDateUtils.storageDateFormat.format(dateFinished),
      "isActive": isActive,
    };
  }

  factory RegisterProfessorDto.fromJson(String source) =>
      RegisterProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
