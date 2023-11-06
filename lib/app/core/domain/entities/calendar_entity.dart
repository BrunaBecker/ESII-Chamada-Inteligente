import 'event_entity.dart';

class CalendarEntity {
  CalendarEntity({
    required this.id,
    required this.events,
  });

  int id;
  List<EventEntity> events;
}
