import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/setting_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/setting_dto.dart';
import '../base_provider.dart';

class SettingProvider extends BaseProvider {
  Http http;

  SettingProvider({required this.http});

  Future<SettingEntity?> fetchById(int settingId) async {
    try {
      final response = await http.get(
        '/setting/$settingId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return SettingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<SettingEntity?> create(SettingEntity settingEntity) async {
    SettingDto settingDto = SettingDto.fromEntity(settingEntity);

    try {
      final response = await http.post(
        '/setting',
        body: settingDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return SettingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<SettingEntity?> update(SettingEntity settingEntity) async {
    SettingDto settingDto = SettingDto.fromEntity(settingEntity);

    try {
      final response = await http.put(
        '/setting',
        body: settingDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return SettingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<SettingEntity?> fetchByPersonRegister(int personRegister) async {
    try {
      final response = await http.get(
        '/setting/person/$personRegister',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return SettingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
