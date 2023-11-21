import '../../data/repositories/get_student_attendance_statuses_by_classroom_repository.dart';
import '../entities/attendance_status_entity.dart';

class GetStudentAttendanceStatusesByClassroomUsecase {
  final GetStudentAttendanceStatusesByClassroomRepository
      _attendanceStatusRepository;

  GetStudentAttendanceStatusesByClassroomUsecase(
      this._attendanceStatusRepository);

  Future<List<AttendanceStatusEntity>?> call({
    required int studentId,
    required int classroomId,
  }) async {
    return await _attendanceStatusRepository(
      studentId: studentId,
      classroomId: classroomId,
    );
  }
}
