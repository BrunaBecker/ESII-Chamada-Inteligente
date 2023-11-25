import '../../data/repositories/get_professor_attendance_happening_repository.dart';
import '../entities/attendance_entity.dart';

class GetProfessorAttendanceHappeningUsecase {
  final GetProfessorAttendanceHappeningRepository
      _getProfessorAttendanceHappeningRepository;

  GetProfessorAttendanceHappeningUsecase(
      this._getProfessorAttendanceHappeningRepository);

  Future<AttendanceEntity> call({required int professorId}) async {
    return await _getProfessorAttendanceHappeningRepository(professorId);
  }
}
