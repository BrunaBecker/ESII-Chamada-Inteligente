import '../../data/repositories/get_student_attendance_happening_repository.dart';
import '../entities/attendance_entity.dart';

class GetStudentAttendanceHappeningUsecase {
  final GetStudentAttendanceHappeningRepository
      _getStudentAttendanceHappeningRepository;

  GetStudentAttendanceHappeningUsecase(
      this._getStudentAttendanceHappeningRepository);

  Future<AttendanceEntity> call({required int studentId}) async {
    return await _getStudentAttendanceHappeningRepository(studentId);
  }
}
