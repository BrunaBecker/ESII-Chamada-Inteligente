import '../../domain/entities/attendance_status_entity.dart';
import '../providers/api/attendance_status_provider.dart';

class CreateStudentAttendanceStatusRepository {
  CreateStudentAttendanceStatusRepository({
    required attendanceStatusProvider,
  }) : _attendanceStatusProvider = attendanceStatusProvider;

  final AttendanceStatusProvider _attendanceStatusProvider;

  Future<AttendanceStatusEntity> call({
    required AttendanceStatusEntity attendanceStatus,
  }) async {
    return await _attendanceStatusProvider.create(attendanceStatus);
  }
}
