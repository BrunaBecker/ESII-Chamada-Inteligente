import 'dart:convert';

import '../../domain/entities/waiver_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_status_dto.dart';
import 'comment_dto.dart';
import 'file_mac_fi_dto.dart';
import 'student_dto.dart';

class WaiverDto extends WaiverEntity {
  WaiverDto({
    required super.id,
    required super.file,
    required super.sendDate,
    required super.acceptionDate,
    required super.isAccepted,
    required super.comment,
    required super.student,
    required super.attendanceStatus,
  });

  factory WaiverDto.fromEntity(WaiverEntity entity) {
    return WaiverDto(
      id: entity.id,
      file: entity.file,
      sendDate: entity.sendDate,
      acceptionDate: entity.acceptionDate,
      isAccepted: entity.isAccepted,
      comment: entity.comment,
      student: entity.student,
      attendanceStatus: entity.attendanceStatus,
    );
  }

  factory WaiverDto.fromMap(Map<String, dynamic> map) {
    return WaiverDto(
      id: map["id"],
      file: FileMacFiDto.fromMap(map["file"]),
      sendDate: AppDateUtils.storageDateFormat.parse(map["sendDate"]),
      acceptionDate: AppDateUtils.storageDateFormat.parse(map["acceptionDate"]),
      isAccepted: map["isAccepted"],
      comment: CommentDto.fromMap(map["comment"]),
      student: StudentDto.fromMap(map["student"]),
      attendanceStatus: AttendanceStatusDto.fromMap(map["attendanceStatus"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "file": FileMacFiDto.fromEntity(file).toMap(),
      "sendDate": AppDateUtils.storageDateFormat.format(sendDate),
      "acceptionDate": AppDateUtils.storageDateFormat.format(acceptionDate),
      "isAccepted": isAccepted,
      "comment": CommentDto.fromEntity(comment).toMap(),
      "student": StudentDto.fromEntity(student).toMap(),
      "attendanceStatus": AttendanceStatusDto.fromEntity(attendanceStatus).toMap(),
    };
  }

  factory WaiverDto.fromJson(String source) => WaiverDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
