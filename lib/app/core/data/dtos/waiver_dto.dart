import 'dart:convert';

import '../../domain/entities/waiver_entity.dart';
import '../../utils/app_date_utils.dart';
import 'comment_dto.dart';
import 'file_mac_fi_dto.dart';
import 'student_dto.dart';

class WaiverDto extends WaiverEntity {
  WaiverDto({
    super.id,
    required super.file,
    required super.description,
    required super.sendDate,
    super.acceptionDate,
    super.isAccepted = false,
    super.comment,
    required super.student,
    required super.attendanceStatusId,
  });

  factory WaiverDto.fromEntity(WaiverEntity entity) {
    return WaiverDto(
      id: entity.id,
      file: entity.file,
      description: entity.description,
      sendDate: entity.sendDate,
      acceptionDate: entity.acceptionDate,
      isAccepted: entity.isAccepted,
      comment: entity.comment,
      student: entity.student,
      attendanceStatusId: entity.attendanceStatusId,
    );
  }

  factory WaiverDto.fromMap(Map<String, dynamic> map) {
    // Mapping Acception Date
    DateTime? acceptionDate;
    if (map["acceptionDate"] != null) {
      acceptionDate = AppDateUtils.storageDateFormat.parse(
        map["acceptionDate"],
      );
    }
    // Mapping comment
    CommentDto? comment;
    if (map["comment"] != null) {
      comment = CommentDto.fromMap(map["comment"]);
    }

    return WaiverDto(
      id: map["id"],
      file: FileMacFiDto.fromMap(map["file"]),
      description: map["description"],
      sendDate: AppDateUtils.storageDateFormat.parse(map["sendDate"]),
      acceptionDate: acceptionDate,
      isAccepted: map["accepted"],
      comment: comment,
      student: StudentDto.fromMap(map["student"]),
      attendanceStatusId: map["attendanceStatusId"],
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Acception Date
    String? acceptionDateAsString;
    if (acceptionDate != null) {
      acceptionDateAsString = AppDateUtils.storageDateFormat.format(
        acceptionDate!,
      );
    }

    // Mapping Comment
    Map<String, dynamic>? commentAsMap;
    if (comment != null) {
      commentAsMap = CommentDto.fromEntity(comment!).toMap();
    }

    return {
      "id": id,
      "file": FileMacFiDto.fromEntity(file).toMap(),
      "description": description,
      "sendDate": AppDateUtils.storageDateFormat.format(sendDate),
      "acceptionDate": acceptionDateAsString,
      "accepted": isAccepted,
      "comment": commentAsMap,
      "student": StudentDto.fromEntity(student).toMap(),
      "attendanceStatusId": attendanceStatusId,
    };
  }

  factory WaiverDto.fromJson(String source) =>
      WaiverDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
