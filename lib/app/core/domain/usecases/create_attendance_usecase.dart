import '../../data/repositories/create_attendance_repository.dart';
import '../entities/attendance_entity.dart';

class CreateAttendanceUsecase {
  final CreateAttendanceRepository _attendanceRepository;

  CreateAttendanceUsecase(this._attendanceRepository);

  Future<AttendanceEntity> call({
    required AttendanceEntity attendance,
  }) async {
    return await _attendanceRepository(
      attendance: attendance,
    );
  }
}
