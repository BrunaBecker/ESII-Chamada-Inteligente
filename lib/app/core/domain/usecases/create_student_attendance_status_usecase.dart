import '../../data/repositories/create_student_attendance_status_repository.dart';
import '../entities/attendance_status_entity.dart';

class CreateStudentAttendanceStatusUsecase {
  final CreateStudentAttendanceStatusRepository _attendanceStatusRepository;

  CreateStudentAttendanceStatusUsecase(this._attendanceStatusRepository);

  Future<AttendanceStatusEntity> call({
    required AttendanceStatusEntity attendanceStatus,
  }) async {
    return await _attendanceStatusRepository(
      attendanceStatus: attendanceStatus,
    );
  }
}
