import 'dart:convert';

import '../../domain/entities/register_professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'professor_dto.dart';

class RegisterProfessorDto extends RegisterProfessorEntity {
  RegisterProfessorDto({
    required super.id,
    required super.professor,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
  });

  factory RegisterProfessorDto.fromEntity(RegisterProfessorEntity entity) {
    return RegisterProfessorDto(
      id: entity.id,
      professor: entity.professor,
      identifier: entity.identifier,
      dateStarted: entity.dateStarted,
      dateFinished: entity.dateFinished,
      isActive: entity.isActive,
    );
  }

  factory RegisterProfessorDto.fromMap(Map<String, dynamic> map) {
    return RegisterProfessorDto(
      id: map["id"],
      professor: ProfessorDto.fromMap(map["professor"]),
      identifier: map["identifier"],
      dateStarted: AppDateUtils.storageDateFormat.parse(map["dateStarted"]),
      dateFinished: AppDateUtils.storageDateFormat.parse(map["dateFinished"]),
      isActive: map["isActive"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "professor": ProfessorDto.fromEntity(professor).toMap(),
      "identifier": identifier,
      "dateStarted": AppDateUtils.storageDateFormat.format(dateStarted),
      "dateFinished": AppDateUtils.storageDateFormat.format(dateFinished),
      "isActive": isActive,
    };
  }

  factory RegisterProfessorDto.fromJson(String source) => RegisterProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
