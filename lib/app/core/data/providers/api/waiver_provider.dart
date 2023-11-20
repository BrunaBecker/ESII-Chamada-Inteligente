import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/waiver_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/waiver_dto.dart';
import '../base_provider.dart';

class WaiverProvider extends BaseProvider {
  Http http;

  WaiverProvider({required this.http});

  Future<WaiverEntity?> create(WaiverEntity waiverEntity) async {
    WaiverDto waiverDto = WaiverDto.fromEntity(waiverEntity);

    try {
      final response = await http.post(
        '/waiver',
        body: waiverDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return WaiverDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<WaiverDto?> fetchByStudentAndClassroom(
      int studentId, int classroomId) async {
    try {
      final response = await http.get(
        '/waiver/student/$studentId/classroom/$classroomId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return WaiverDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<WaiverDto?> fetchById(int waiverId) async {
    try {
      final response = await http.get(
        '/waiver/$waiverId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return WaiverDto.fromMap(response.data);
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
