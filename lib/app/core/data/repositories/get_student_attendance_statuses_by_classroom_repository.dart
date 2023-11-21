import '../../domain/entities/attendance_status_entity.dart';
import '../providers/api/attendance_status_provider.dart';

class GetStudentAttendanceStatusesByClassroomRepository {
  GetStudentAttendanceStatusesByClassroomRepository({
    required attendanceStatusProvider,
  }) : _attendanceStatusProvider = attendanceStatusProvider;

  final AttendanceStatusProvider _attendanceStatusProvider;

  Future<List<AttendanceStatusEntity>?> call({
    required int studentId,
    required int classroomId,
  }) async {
    return await _attendanceStatusProvider.fetchAllByStudentIdAndClassroomId(
      studentId,
      classroomId,
    );
  }
}
