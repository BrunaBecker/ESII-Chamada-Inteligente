import '../../data/repositories/end_attendance_repository.dart';
import '../entities/attendance_entity.dart';

class EndAttendanceUsecase {
  final EndAttendanceRepository _attendanceRepository;

  EndAttendanceUsecase(this._attendanceRepository);

  Future<AttendanceEntity> call({
    required int attendanceId,
  }) async {
    return await _attendanceRepository(
      attendanceId: attendanceId,
    );
  }
}
