class VirtualZoneEntity {
  VirtualZoneEntity({
    this.id,
    required this.locationId,
    required this.attendanceId,
  });

  int? id;
  int locationId;
  int attendanceId;
}
