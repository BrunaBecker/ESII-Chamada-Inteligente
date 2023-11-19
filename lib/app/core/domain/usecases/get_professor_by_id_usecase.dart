import '../../data/repositories/get_professor_by_id_repository.dart';
import '../entities/professor_entity.dart';

class GetProfessorByIdUsecase {
  final GetProfessorByIdRepository _getProfessorByIdRepository;

  GetProfessorByIdUsecase(this._getProfessorByIdRepository);

  Future<ProfessorEntity?> call(int professorId) async {
    return await _getProfessorByIdRepository(professorId);
  }
}
