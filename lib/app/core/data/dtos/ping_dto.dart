import 'dart:convert';

import '../../domain/entities/ping_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_status_dto.dart';

class PingDto extends PingEntity {
  PingDto({
    required super.ip,
    required super.id,
    required super.date,
    required super.status,
    required super.attendanceStatus,
  });

  factory PingDto.fromEntity(PingEntity entity) {
    return PingDto(
      ip: entity.ip,
      id: entity.id,
      date: entity.date,
      status: entity.status,
      attendanceStatus: entity.attendanceStatus,
    );
  }

  factory PingDto.fromMap(Map<String, dynamic> map) {
    return PingDto(
      ip: map["ip"],
      id: map["id"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      status: map["status"],
      attendanceStatus: AttendanceStatusDto.fromMap(map["attendanceStatus"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ip": ip,
      "id": id,
      "date": AppDateUtils.storageDateFormat.format(date),
      "status": status,
      "attendanceStatus": AttendanceStatusDto.fromEntity(attendanceStatus).toMap(),
    };
  }

  factory PingDto.fromJson(String source) => PingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
