import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class CreateAttendanceRepository {
  CreateAttendanceRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<AttendanceEntity> call({
    required AttendanceEntity attendance,
  }) async {
    return await _attendanceProvider.create(attendance);
  }
}
