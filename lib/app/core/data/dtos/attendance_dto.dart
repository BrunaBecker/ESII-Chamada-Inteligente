import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_status_dto.dart';
import 'classroom_dto.dart';
import 'virtual_zone_dto.dart';

class AttendanceDto extends AttendanceEntity {
  AttendanceDto({
    required super.id,
    required super.date,
    required super.supportingText,
    required super.startHour,
    required super.endHour,
    required super.duration,
    required super.isAutomatic,
    required super.isHappening,
    required super.virtualZone,
    required super.classroom,
    required super.statusStudentAttendance,
  });

  factory AttendanceDto.fromEntity(AttendanceEntity entity) {
    return AttendanceDto(
      id: entity.id,
      date: entity.date,
      supportingText: entity.supportingText,
      startHour: entity.startHour,
      endHour: entity.endHour,
      duration: entity.duration,
      isAutomatic: entity.isAutomatic,
      isHappening: entity.isHappening,
      virtualZone: entity.virtualZone,
      classroom: entity.classroom,
      statusStudentAttendance: entity.statusStudentAttendance,
    );
  }

  factory AttendanceDto.fromMap(Map<String, dynamic> map) {
    // Mapping StatusStudentAttendance
    List<AttendanceStatusDto> statusStudentAttendance = [];
    for (var statusStudentAttendanceMap in map["statusStudentAttendance"]) {
      statusStudentAttendance
          .add(AttendanceStatusDto.fromMap(statusStudentAttendanceMap));
    }

    return AttendanceDto(
      id: map["id"],
      date: AppDateUtils.storageDateFormat.parse(map["date"]),
      supportingText: map["supportingText"],
      startHour: TimeOfDay.fromDateTime(
          AppDateUtils.storageDateFormat.parse(map["startHour"])),
      endHour: TimeOfDay.fromDateTime(
          AppDateUtils.storageDateFormat.parse(map["endHour"])),
      duration: map["duration"],
      isAutomatic: map["isAutomatic"],
      isHappening: map["isHappening"],
      virtualZone: map["virtualZone"],
      classroom: map["classroom"],
      statusStudentAttendance: statusStudentAttendance,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping StatusStudentAttendance
    List<Map<String, dynamic>> statusStudentAttendanceAsMap = [];
    for (var statusStudentAttendance in this.statusStudentAttendance) {
      statusStudentAttendanceAsMap
          .add(AttendanceStatusDto.fromEntity(statusStudentAttendance).toMap());
    }

    return {
      "id": id,
      "date": AppDateUtils.storageDateFormat.format(date),
      "supportingText": supportingText,
      "startHour": startHour.toString(),
      "endHour": endHour.toString(),
      "duration": duration,
      "isAutomatic": isAutomatic,
      "isHappening": isHappening,
      "virtualZone": VirtualZoneDto.fromEntity(virtualZone).toMap(),
      "classroom": ClassroomDto.fromEntity(classroom).toMap(),
      "statusStudentAttendance": statusStudentAttendanceAsMap,
    };
  }

  factory AttendanceDto.fromJson(String json) =>
      AttendanceDto.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
