import '../../data/repositories/get_student_attendance_status_by_attendance_repository.dart';
import '../entities/attendance_status_entity.dart';

class GetStudentAttendanceStatusByAttendanceUsecase {
  final GetStudentAttendanceStatusByAttendanceRepository
      _attendanceStatusRepository;

  GetStudentAttendanceStatusByAttendanceUsecase(
      this._attendanceStatusRepository);

  Future<AttendanceStatusEntity> call({
    required int studentId,
    required int attendanceId,
  }) async {
    return await _attendanceStatusRepository(
      studentId: studentId,
      attendanceId: attendanceId,
    );
  }
}
