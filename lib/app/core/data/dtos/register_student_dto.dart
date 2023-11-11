import 'dart:convert';

import '../../domain/entities/register_student_entity.dart';
import '../../utils/app_date_utils.dart';

class RegisterStudentDto extends RegisterStudentEntity {
  RegisterStudentDto({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    required super.isActive,
  });

  factory RegisterStudentDto.fromEntity(RegisterStudentEntity entity) {
    return RegisterStudentDto(
      id: entity.id,
      identifier: entity.identifier,
      dateStarted: entity.dateStarted,
      dateFinished: entity.dateFinished,
      isActive: entity.isActive,
    );
  }

  factory RegisterStudentDto.fromMap(Map<String, dynamic> map) {
    return RegisterStudentDto(
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

  factory RegisterStudentDto.fromJson(String source) =>
      RegisterStudentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
