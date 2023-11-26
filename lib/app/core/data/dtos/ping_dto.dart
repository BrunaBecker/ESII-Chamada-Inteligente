import 'dart:convert';

import '../../domain/entities/ping_entity.dart';
import '../../enums/status_ping.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_status_dto.dart';
import 'coordinate_dto.dart';

class PingDto extends PingEntity {
  PingDto({
    super.id,
    super.ip,
    required super.date,
    super.status,
    required super.isContinuous,
    super.coordinate,
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
    // Mapping Status
    StatusPing? status;
    if (map["status"] != null) {
      status = StatusPing.fromText(map["status"]);
    }
    // Mapping Coordinate
    CoordinateDto? coordinate;
    if (map["coordinate"] != null) {
      coordinate = CoordinateDto.fromMap(map["coordinate"]);
    }

    return PingDto(
      id: map["id"],
      ip: map["ip"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      status: status,
      isContinuous: map["isContinuos"],
      coordinate: coordinate,
      attendanceStatus: AttendanceStatusDto.fromMap(map["attendanceStatus"]),
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Status
    String? statusAsString;
    if (status != null) {
      statusAsString = status!.toText();
    }
    // Mapping Coordinate
    Map<String, dynamic>? coordinateAsMap;
    if (coordinate != null) {
      coordinateAsMap = CoordinateDto.fromEntity(coordinate!).toMap();
    }

    return {
      "id": id,
      "ip": ip,
      "date": AppDateUtils.storageDateFormat.format(date),
      "status": statusAsString,
      "isContinuos": isContinuous,
      "coordinate": coordinateAsMap,
      "attendanceStatus":
          AttendanceStatusDto.fromEntity(attendanceStatus).toMap(),
    };
  }

  factory PingDto.fromJson(String source) =>
      PingDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
