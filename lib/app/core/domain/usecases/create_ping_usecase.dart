import '../../data/repositories/create_ping_repository.dart';
import '../entities/ping_entity.dart';

class CreatePingUsecase {
  final CreatePingRepository _pingRepository;

  CreatePingUsecase(this._pingRepository);

  Future<PingEntity> call({
    required PingEntity ping,
  }) async {
    return await _pingRepository(
      ping: ping,
    );
  }
}
