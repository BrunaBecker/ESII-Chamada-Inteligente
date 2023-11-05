import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../domain/entities/register_professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'professor_dto.dart';

class RegisterProfessorDto extends RegisterProfessorEntity {
  RegisterProfessorDto({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
    required super.person,
  });

  factory RegisterProfessorDto.fromEntity(RegisterProfessorEntity entity) {
    return RegisterProfessorDto(
      id: entity.id,
      identifier: entity.identifier,
      dateStarted: entity.dateStarted,
      dateFinished: entity.dateFinished,
      isActive: entity.isActive,
      person: ProfessorDto.fromEntity(entity.person as ProfessorEntity),
    );
  }

  factory RegisterProfessorDto.fromMap(Map<String, dynamic> map) {
    return RegisterProfessorDto(
      id: map["id"],
      identifier: map["identifier"],
      dateStarted: AppDateUtils.storageDateFormat.parse(map["dateStarted"]),
      dateFinished: AppDateUtils.storageDateFormat.parse(map["dateFinished"]),
      isActive: map["isActive"],
      person: ProfessorDto.fromMap(map["person"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "identifier": identifier,
      "dateStarted": AppDateUtils.storageDateFormat.format(dateStarted),
      "dateFinished": AppDateUtils.storageDateFormat.format(dateFinished),
      "isActive": isActive,
      "person": ProfessorDto.fromEntity(person as ProfessorEntity).toMap(),
    };
  }

  factory RegisterProfessorDto.fromJson(String source) => RegisterProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
