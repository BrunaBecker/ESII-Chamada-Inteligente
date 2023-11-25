import '../../domain/entities/attendance_status_entity.dart';
import '../providers/api/attendance_status_provider.dart';

class GetStudentAttendanceStatusByAttendanceRepository {
  GetStudentAttendanceStatusByAttendanceRepository({
    required attendanceStatusProvider,
  }) : _attendanceStatusProvider = attendanceStatusProvider;

  final AttendanceStatusProvider _attendanceStatusProvider;

  Future<AttendanceStatusEntity> call({
    required int studentId,
    required int attendanceId,
  }) async {
    return await _attendanceStatusProvider.fetchByAttendanceAndStudent(
      studentId,
      attendanceId,
    );
  }
}
