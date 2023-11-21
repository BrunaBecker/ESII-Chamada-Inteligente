import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/ping_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/ping_dto.dart';
import '../base_provider.dart';

class PingProvider extends BaseProvider {
  Http http;

  PingProvider({required this.http});

  Future<PingEntity> createPing(PingEntity ping) async {
    PingDto pingDto = PingDto.fromEntity(ping);
    try {
      final response = await http.post(
        '/ping',
        body: pingDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return PingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<PingEntity> fetchById(int pingId) async {
    try {
      final response = await http.get(
        '/ping/$pingId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return PingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }
}
