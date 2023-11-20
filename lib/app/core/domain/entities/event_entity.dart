import '../../enums/event_status.dart';

class EventEntity {
  EventEntity({
    this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.classroomId,
    required this.status,
  });

  int? id;
  String name;
  DateTime date;
  String description;
  int classroomId;
  EventStatus status;
}
