import '../../enums/event_status.dart';
import 'calendar_entity.dart';
import 'classroom_entity.dart';

class EventEntity {
  EventEntity({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.classroom,
    required this.status,
    required this.calendars,
  });

  int id;
  String name;
  DateTime date;
  String description;
  ClassroomEntity classroom;
  EventStatus status;
  List<CalendarEntity> calendars;
}
