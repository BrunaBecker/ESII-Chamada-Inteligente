import 'event_entity.dart';

class CalendarEntity {
  CalendarEntity({
    this.id,
    required this.events,
  });

  int? id;
  List<EventEntity> events;
}
