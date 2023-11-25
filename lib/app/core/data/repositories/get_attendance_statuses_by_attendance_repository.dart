import '../../domain/entities/attendance_status_entity.dart';
import '../providers/api/attendance_status_provider.dart';

class GetAttendanceStatusesByAttendanceRepository {
  GetAttendanceStatusesByAttendanceRepository({
    required attendanceStatusProvider,
  }) : _attendanceStatusProvider = attendanceStatusProvider;

  final AttendanceStatusProvider _attendanceStatusProvider;

  Future<List<AttendanceStatusEntity>> call(int attendanteId) async {
    return await _attendanceStatusProvider.fetchAllByAttendanceId(attendanteId);
  }
}
