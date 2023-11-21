import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/setting_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/setting_dto.dart';
import '../base_provider.dart';

class SettingProvider extends BaseProvider {
  Http http;

  SettingProvider({required this.http});

  Future<SettingEntity> fetchById(int settingId) async {
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
      throw UnexpectedApiException();
    }
  }

  Future<SettingEntity> create(SettingEntity settingEntity) async {
    SettingDto settingDto = SettingDto.fromEntity(settingEntity);

    try {
      final response = await http.post(
        '/setting',
        body: settingDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return SettingDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<SettingEntity> update(SettingEntity settingEntity) async {
    SettingDto settingDto = SettingDto.fromEntity(settingEntity);

    try {
      final response = await http.put(
        '/setting',
        body: settingDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<SettingEntity> fetchByPersonRegister(String identifier) async {
    try {
      final response = await http.get(
        '/setting/person/$identifier',
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
      throw UnexpectedApiException();
    }
  }

  Future<SettingEntity> fetchByPersonId(int id) async {
    try {
      final response = await http.get(
        '/setting/person/$id',
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
      throw UnexpectedApiException();
    }
  }

  Future<SettingEntity> setPerson(int id, int personId) async {
    try {
      final response = await http.put(
        '/setting/setPerson?',
        query: {
          'id': id,
          'personId': personId,
        },
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
      throw UnexpectedApiException();
    }
  }

}
