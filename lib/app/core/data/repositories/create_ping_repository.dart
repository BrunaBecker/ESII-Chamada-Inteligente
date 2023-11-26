import '../../domain/entities/ping_entity.dart';
import '../providers/api/ping_provider.dart';

class CreatePingRepository {
  CreatePingRepository({
    required pingProvider,
  }) : _pingProvider = pingProvider;

  final PingProvider _pingProvider;

  Future<PingEntity> call({
    required PingEntity ping,
  }) async {
    return await _pingProvider.createPing(ping);
  }
}
