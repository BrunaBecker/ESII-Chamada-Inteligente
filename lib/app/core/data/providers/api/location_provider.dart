import 'dart:ffi';

import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../dtos/location_dto.dart';
import '../base_provider.dart';

class LocationProvider extends BaseProvider {
  Http http;

  LocationProvider({required this.http});

  Future<LocationEntity?> create(LocationEntity locationEntity) async {
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

      return LocationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<LocationEntity?> update(LocationEntity locationEntity) async {
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

      return LocationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<LocationEntity?> addVirtualZone(
      LocationEntity locationEntity, int virtualZoneId) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.put(
        '/location/addVirtualZone/$virtualZoneId',
        body: locationDto.toJson(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return LocationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  Future<List<LocationEntity>?> fetchAllByProfessorRegister(
      Long professorRegister) async {
    try {
      final response = await http.get(
        '/location/byProfessor/$professorRegister',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      List<LocationEntity> locations = response.data
          .map<LocationDto>(
            (location) => LocationDto.fromMap(location),
          )
          .toList();

      return locations;
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
