import '../../domain/entities/statistics_entity.dart';
import '../providers/api/statistics_provider.dart';

class GetStatisticsRepository {
  GetStatisticsRepository({
    required statisticsProvider,
  }) : _statisticsProvider = statisticsProvider;

  final StatisticsProvider _statisticsProvider;

  Future<StatisticsEntity> call(int classroomId, int studentId) async {
    return await _statisticsProvider.fetchByClassroomAndStudent(classroomId, studentId);
  }
}
