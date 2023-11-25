import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class EndAttendanceRepository {
  EndAttendanceRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<AttendanceEntity> call({
    required int attendanceId,
  }) async {
    return await _attendanceProvider.endAttendance(attendanceId);
  }
}
