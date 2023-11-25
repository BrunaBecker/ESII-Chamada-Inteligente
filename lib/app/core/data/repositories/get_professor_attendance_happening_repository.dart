import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class GetProfessorAttendanceHappeningRepository {
  GetProfessorAttendanceHappeningRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<AttendanceEntity> call(int professorId) async {
    return await _attendanceProvider.fetchHappeningByProfessorId(professorId);
  }
}
