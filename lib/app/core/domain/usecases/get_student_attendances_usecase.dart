import '../../data/repositories/get_student_attendances_repository.dart';
import '../entities/attendance_entity.dart';

class GetStudentAttendancesUsecase {
  final GetStudentAttendancesRepository _getStudentAttendancesRepository;

  GetStudentAttendancesUsecase(this._getStudentAttendancesRepository);

  Future<List<AttendanceEntity>?> call({required int studentId}) async {
    return await _getStudentAttendancesRepository(studentId);
  }
}
