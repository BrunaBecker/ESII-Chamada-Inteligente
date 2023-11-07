import 'dart:convert';

import '../../domain/entities/coordinate_dto.dart';
import '../../domain/entities/ping_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_status_dto.dart';

class PingDto extends PingEntity {
  PingDto({
    required super.id,
    required super.ip,
    required super.date,
    required super.status,
    required super.isContinuous,
    required super.coordinate,
    required super.attendanceStatus,
  });

  factory PingDto.fromEntity(PingEntity entity) {
    return PingDto(
      id: entity.id,
      ip: entity.ip,
      date: entity.date,
      status: entity.status,
      isContinuous: entity.isContinuous,
      coordinate: entity.coordinate,
      attendanceStatus: entity.attendanceStatus,
    );
  }

  factory PingDto.fromMap(Map<String, dynamic> map) {
    return PingDto(
      id: map["id"],
      ip: map["ip"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      status: map["status"],
      isContinuous: map["isContinuous"],
      coordinate: CoordinateDto.fromMap(map["coordinate"]),
      attendanceStatus: AttendanceStatusDto.fromMap(map["attendanceStatus"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ip": ip,
      "id": id,
      "date": AppDateUtils.storageDateFormat.format(date),
      "status": status,
      "isContinuous": isContinuous,
      "coordinate": CoordinateDto.fromEntity(coordinate).toMap(),
      "attendanceStatus":
          AttendanceStatusDto.fromEntity(attendanceStatus).toMap(),
    };
  }

  factory PingDto.fromJson(String source) =>
      PingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
