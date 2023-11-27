import 'dart:core';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/statistics_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/statistics_dto.dart';
import '../base_provider.dart';

class StatisticsProvider extends BaseProvider {
  Http http;

  StatisticsProvider({required this.http});

  // localhost:8080/statistic?idClassroom=1&idStudent=1
  Future<StatisticsEntity> fetchByClassroomAndStudent(
    int idClassroom,
    int idStudent,
  ) async {
    try {
      final response = await http.get(
        "/statistic",
        query: {
          "idClassroom": idClassroom,
          "idStudent": idStudent,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return StatisticsDto.fromMap(response.data);
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
