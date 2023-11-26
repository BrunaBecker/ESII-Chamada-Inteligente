import '../../enums/student_at_attendance_state.dart';
import 'attendance_entity.dart';
import 'student_entity.dart';

class AttendanceStatusEntity {
  AttendanceStatusEntity({
    this.id,
    required this.studentState,
    this.studentHasResponded = false,
    this.validated = false,
    required this.student,
    required this.attendance,
  });

  int? id;
  StudentAtAttendanceState studentState;
  bool studentHasResponded;
  bool validated;
  StudentEntity student;
  AttendanceEntity attendance;
}
