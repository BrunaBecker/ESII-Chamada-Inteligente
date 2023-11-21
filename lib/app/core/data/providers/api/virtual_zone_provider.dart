import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/virtual_zone_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/virtual_zone_dto.dart';
import '../base_provider.dart';

class VirtualZoneProvider extends BaseProvider {
  Http http;

  VirtualZoneProvider({required this.http});

  Future<List<VirtualZoneEntity>> fetchAll() async {
    try {
      final response = await http.get(
        '/virtualZone',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final virtualZones = response.data
          .map<VirtualZoneDto>(
            (virtualZone) => VirtualZoneDto.fromMap(virtualZone),
          )
          .toList();

      return virtualZones;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<VirtualZoneEntity> create(VirtualZoneEntity virtualZoneEntity) async {
    VirtualZoneDto virtualZoneDto =
        VirtualZoneDto.fromEntity(virtualZoneEntity);
    try {
      final response = await http.post(
        '/virtualZone',
        body: virtualZoneDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return VirtualZoneDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<VirtualZoneEntity> update(VirtualZoneEntity virtualZoneEntity) async {
    VirtualZoneDto virtualZoneDto =
        VirtualZoneDto.fromEntity(virtualZoneEntity);
    try {
      final response = await http.put(
        '/virtualZone',
        body: virtualZoneDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return VirtualZoneDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<VirtualZoneEntity> fetchById(int virtualZoneId) async {
    try {
      final response = await http.get(
        '/virtualZone/$virtualZoneId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return VirtualZoneDto.fromMap(response.data);
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
