import '../dtos/professor_dto.dart';
import '../providers/api/professor_provider.dart';

class GetProfessorByIdRepository {
  GetProfessorByIdRepository({
    required professorProvider,
  }) : _professorProvider = professorProvider;

  final ProfessorProvider _professorProvider;

  Future<ProfessorDto?> call(int professorId) async {
    return await _professorProvider.fetchById(professorId) as ProfessorDto?;
  }
}
