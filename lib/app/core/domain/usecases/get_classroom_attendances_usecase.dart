import '../../data/repositories/get_classroom_attendances_repository.dart';
import '../entities/attendance_entity.dart';

class GetClassroomAttendancesUsecase {
  final GetClassroomAttendancesRepository _getClassroomAttendance;

  GetClassroomAttendancesUsecase(this._getClassroomAttendance);

  Future<List<AttendanceEntity>?> call(int classroomId) async {
    return await _getClassroomAttendance(classroomId);
  }
}
