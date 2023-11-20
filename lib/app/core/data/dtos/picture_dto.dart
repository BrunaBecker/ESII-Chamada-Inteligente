import 'dart:convert';

import '../../domain/entities/picture_entity.dart';
import '../../utils/app_date_utils.dart';

class PictureDto extends PictureEntity {
  PictureDto({
    super.id,
    required super.linkFile,
    required super.nameFile,
    required super.typeFile,
    required super.sizeFile,
    required super.dateFile,
  });

  factory PictureDto.fromEntity(PictureEntity entity) {
    return PictureDto(
      id: entity.id,
      linkFile: entity.linkFile,
      nameFile: entity.nameFile,
      typeFile: entity.typeFile,
      sizeFile: entity.sizeFile,
      dateFile: entity.dateFile,
    );
  }

  factory PictureDto.fromMap(Map<String, dynamic> map) {
    return PictureDto(
      id: map["id"],
      linkFile: map["linkFile"],
      nameFile: map["nameFile"],
      typeFile: map["typeFile"],
      sizeFile: map["sizeFile"],
      dateFile: AppDateUtils.storageDateFormat.parse(map["dateFile"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "linkFile": linkFile,
      "nameFile": nameFile,
      "typeFile": typeFile,
      "sizeFile": sizeFile,
      "dateFile": AppDateUtils.storageDateFormat.format(dateFile),
    };
  }

  factory PictureDto.fromJson(String source) =>
      PictureDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
