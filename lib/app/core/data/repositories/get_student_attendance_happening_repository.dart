import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class GetStudentAttendanceHappeningRepository {
  GetStudentAttendanceHappeningRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<AttendanceEntity> call(int studentId) async {
    return await _attendanceProvider.fetchHappeningByStudentId(studentId);
  }
}
