import '../../enums/student_at_attendance_state.dart';
import 'attendance_entity.dart';
import 'ping_entity.dart';
import 'student_entity.dart';

class AttendanceStatusEntity {
  AttendanceStatusEntity({
    required this.id,
    required this.studentState,
    required this.studentHasResponded,
    required this.validated,
    required this.student,
    required this.attendance,
    required this.successfulPings,
    required this.unsuccessfulPings,
  });

  int id;
  StudentAtAttendanceState studentState;
  bool studentHasResponded;
  bool validated;
  StudentEntity student;
  AttendanceEntity attendance;
  List<PingEntity> successfulPings;
  List<PingEntity> unsuccessfulPings;
}
