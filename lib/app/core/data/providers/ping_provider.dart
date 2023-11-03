import '../../adapters/http_adapter.dart';
import '../dtos/ping_dto.dart';
import 'base_provider.dart';

class PingProvider extends BaseProvider {
  Http http;

  PingProvider({required this.http});

  Future<dynamic> ping(PingDto ping) async {
    try {
      final response = await http.post(
        '/ping',
        body: ping.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data.status;
    } catch (e) {
      logError(e.toString());
    }
  }
}
