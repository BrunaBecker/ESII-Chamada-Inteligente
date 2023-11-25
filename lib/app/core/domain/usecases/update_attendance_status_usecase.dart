import '../../data/repositories/update_attendance_status_repository.dart';
import '../entities/attendance_status_entity.dart';

class UpdateAttendanceStatusUsecase {
  final UpdateAttendanceStatusRepository _attendanceStatusRepository;

  UpdateAttendanceStatusUsecase(this._attendanceStatusRepository);

  Future<AttendanceStatusEntity> call({
    required AttendanceStatusEntity attendanceStatus,
  }) async {
    return await _attendanceStatusRepository(
      attendanceStatus: attendanceStatus,
    );
  }
}
