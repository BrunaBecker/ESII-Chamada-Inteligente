import 'dart:convert';

import '../../domain/entities/file_mac_fi_entity.dart';
import '../../utils/app_date_utils.dart';

class FileMacFiDto extends FileMacFiEntity {
  FileMacFiDto({
    required super.linkFile,
    required super.nameFile,
    required super.typeFile,
    required super.sizeFile,
    required super.dateFile,
  });

  factory FileMacFiDto.fromEntity(FileMacFiEntity entity) {
    return FileMacFiDto(
      linkFile: entity.linkFile,
      nameFile: entity.nameFile,
      typeFile: entity.typeFile,
      sizeFile: entity.sizeFile,
      dateFile: entity.dateFile,
    );
  }

  factory FileMacFiDto.fromMap(Map<String, dynamic> map) {
    return FileMacFiDto(
      linkFile: map["linkFile"],
      nameFile: map["nameFile"],
      typeFile: map["typeFile"],
      sizeFile: map["sizeFile"],
      dateFile: AppDateUtils.storageDateFormat.parse(map["dateFile"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "linkFile": linkFile,
      "nameFile": nameFile,
      "typeFile": typeFile,
      "sizeFile": sizeFile,
      "dateFile": AppDateUtils.storageDateFormat.format(dateFile),
    };
  }

  factory FileMacFiDto.fromJson(String source) => FileMacFiDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
