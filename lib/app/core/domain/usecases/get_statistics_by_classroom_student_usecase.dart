import '../../data/repositories/get_statistics_by_classroom_student_repository.dart';
import '../entities/statistics_entity.dart';

class GetStatisticsUseCase {
  final GetStatisticsRepository _getStatistics;

  GetStatisticsUseCase(this._getStatistics);

  Future<StatisticsEntity> call(int classroomId, int studentId) async {
    return await _getStatistics(classroomId, studentId);
  }
}
