import 'package:flutter/material.dart';

import 'classroom_entity.dart';
import 'virtual_zone_entity.dart';

class AttendanceEntity {
  AttendanceEntity({
    required this.id,
    required this.date,
    required this.supportingText,
    required this.startHour,
    required this.endHour,
    required this.duration,
    required this.isAutomatic,
    required this.isHappening,
    required this.virtualZone,
    required this.classroom,
  });

  int id;
  DateTime date;
  String supportingText;
  TimeOfDay startHour;
  TimeOfDay endHour;
  String duration;
  bool isAutomatic;
  bool isHappening;
  VirtualZoneEntity virtualZone;
  ClassroomEntity classroom;
}
