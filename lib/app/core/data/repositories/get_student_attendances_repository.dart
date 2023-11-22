import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class GetStudentAttendancesRepository {
  GetStudentAttendancesRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<List<AttendanceEntity>?> call(int studentId) async {
    return await _attendanceProvider.fetchHappeningByStudentId(studentId);
  }
}
