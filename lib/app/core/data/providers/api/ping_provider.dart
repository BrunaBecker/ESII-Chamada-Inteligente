import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/ping_entity.dart';
import '../../dtos/ping_dto.dart';
import '../base_provider.dart';

class PingProvider extends BaseProvider {
  Http http;

  PingProvider({required this.http});

  Future<PingEntity?> ping(PingEntity ping) async {
    PingDto pingDto = PingDto.fromEntity(ping);
    try {
      final response = await http.post(
        '/ping',
        body: pingDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return PingDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
