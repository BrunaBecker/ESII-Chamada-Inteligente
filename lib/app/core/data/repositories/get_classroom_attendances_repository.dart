import '../../domain/entities/attendance_entity.dart';
import '../providers/api/attendance_provider.dart';

class GetClassroomAttendancesRepository {
  GetClassroomAttendancesRepository({
    required attendanceProvider,
  }) : _attendanceProvider = attendanceProvider;

  final AttendanceProvider _attendanceProvider;

  Future<List<AttendanceEntity>?> call(int classroomId) async {
    return await _attendanceProvider.fetchByClassroomId(classroomId);
  }
}
