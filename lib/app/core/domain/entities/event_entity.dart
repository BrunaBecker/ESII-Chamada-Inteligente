import '../../enums/event_status.dart';
import 'classroom_entity.dart';

class EventEntity {
  EventEntity({
    this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.classroom,
    required this.status,
  });

  int? id;
  String name;
  DateTime date;
  String description;
  ClassroomEntity classroom;
  EventStatus status;
}
