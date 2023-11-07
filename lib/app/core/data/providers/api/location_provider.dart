import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/location_entity.dart';
import '../../dtos/location_dto.dart';
import '../base_provider.dart';

class LocationProvider extends BaseProvider {
  Http http;

  LocationProvider({required this.http});

  Future<LocationEntity?> createLocation(LocationEntity locationEntity) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.post(
        '/location',
        body: locationDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return LocationDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<LocationEntity?> updateLocation(LocationEntity locationEntity) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.put(
        '/location',
        body: locationDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return LocationDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<LocationEntity?> fetchLocationByProfessorIdentifier(
      Long professorIdentifier) async {
    try {
      final response = await http.get(
        '/location/byProfessor/$professorIdentifier',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return LocationDto.fromJson(response.data);
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }
}
