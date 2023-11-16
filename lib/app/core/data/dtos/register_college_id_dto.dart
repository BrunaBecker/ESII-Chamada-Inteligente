import 'dart:convert';

import '../../domain/entities/register_college_id_entity.dart';
import '../../utils/app_date_utils.dart';

class RegisterCollegeIdDto extends RegisterCollegeIdEntity {
  RegisterCollegeIdDto({
    required super.id,
    required super.identifier,
    required super.dateStarted,
    super.dateFinished,
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
    DateTime? dateFinished = map["dateFinished"] == null
        ? null
        : AppDateUtils.storageDateFormat.parse(map["dateFinished"]);

    return RegisterCollegeIdDto(
      id: map["id"],
      identifier: map["identifier"],
      dateStarted: AppDateUtils.storageDateFormat.parse(map["dateStarted"]),
      dateFinished: dateFinished,
      isActive: map["active"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "identifier": identifier,
      "dateStarted": AppDateUtils.storageDateFormat.format(dateStarted),
      "dateFinished": dateFinished == null
          ? null
          : AppDateUtils.storageDateFormat.format(dateFinished!),
      "active": isActive,
    };
  }

  factory RegisterCollegeIdDto.fromJson(String source) =>
      RegisterCollegeIdDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
