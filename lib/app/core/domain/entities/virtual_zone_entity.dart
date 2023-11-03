import 'attendance_entity.dart';
import 'location_entity.dart';

class VirtualZoneEntity {
  VirtualZoneEntity({
    required this.id,
    required this.location,
    required this.attendance,
  });

  int id;
  LocationEntity location;
  AttendanceEntity attendance;
}
