import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/setting_entity.dart';
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

      return SettingDto.fromJson(response.data);
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

      return SettingDto.fromJson(response.data);
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

      return SettingDto.fromJson(response.data);
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

      return SettingDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
