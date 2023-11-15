import 'dart:convert';

import '../../domain/entities/register_college_id_entity.dart';
import '../../utils/app_date_utils.dart';

class RegisterCollegeIdDto extends RegisterCollegeIdEntity {
  RegisterCollegeIdDto({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    required super.dateFinished,
    super.isActive,
  });

  factory RegisterCollegeIdDto.fromEntity(RegisterCollegeIdEntity entity) {
    return RegisterCollegeIdDto(
      id: entity.id,
      identifier: entity.identifier,
      dateStarted: entity.dateStarted,
      dateFinished: entity.dateFinished,
      isActive: entity.isActive,
    );
  }

  factory RegisterCollegeIdDto.fromMap(Map<String, dynamic> map) {
    return RegisterCollegeIdDto(
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

  factory RegisterCollegeIdDto.fromJson(String source) =>
      RegisterCollegeIdDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
