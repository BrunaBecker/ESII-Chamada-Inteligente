import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/waiver_entity.dart';
import '../../dtos/waiver_dto.dart';
import '../base_provider.dart';

class WaiverProvider extends BaseProvider {
  Http http;

  WaiverProvider({required this.http});

  Future<WaiverEntity?> createWaiver(WaiverEntity waiverEntity) async {
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

      return WaiverDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<WaiverDto?> fetchWaiverByStudentAndClassroom(
      Long studentId, Long classroomId) async {
    try {
      final response = await http.get(
        '/waiver/student/$studentId/classroom/$classroomId',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return WaiverDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
