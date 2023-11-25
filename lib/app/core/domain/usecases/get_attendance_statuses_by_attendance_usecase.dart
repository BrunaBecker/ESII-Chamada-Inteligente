import '../../data/repositories/get_attendance_statuses_by_attendance_repository.dart';
import '../entities/attendance_status_entity.dart';

class GetAttendanceStatusesByAttendanceUsecase {
  final GetAttendanceStatusesByAttendanceRepository
      _getAttendanceStatusesByAttendanceRepository;

  GetAttendanceStatusesByAttendanceUsecase(
      this._getAttendanceStatusesByAttendanceRepository);

  Future<List<AttendanceStatusEntity>> call(int attendanceId) async {
    return await _getAttendanceStatusesByAttendanceRepository(attendanceId);
  }
}
