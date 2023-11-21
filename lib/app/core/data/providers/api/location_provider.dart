import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/coordinate_entity.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/coordinate_dto.dart';
import '../../dtos/location_dto.dart';
import '../base_provider.dart';

class LocationProvider extends BaseProvider {
  Http http;

  LocationProvider({required this.http});

  Future<LocationEntity> create(LocationEntity locationEntity) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.post(
        '/location',
        body: locationDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return LocationDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> update(LocationEntity locationEntity) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.put(
        '/location',
        body: locationDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> addVirtualZone(
      LocationEntity locationEntity, int virtualZoneId) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);
    try {
      final response = await http.put(
        '/location/addVirtualZone/$virtualZoneId',
        body: locationDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<List<LocationEntity>> fetchAllByProfessorRegister(
      int professorRegister) async {
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> fetchById(int id) async {
    try {
      final response = await http.get(
        '/location/$id',
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> setCoordinate(
      int id, int coordinateId) async {
   
    try {
      final response = await http.put(
        '/location/setCoordinate?',
        query: {
          'id': id,
          'coordinateId': coordinateId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> addCoordinate(int id, CoordinateEntity coordinateEntity) async {
    CoordinateDto coordinateDto = CoordinateDto.fromEntity(coordinateEntity);
    try {
      final response = await http.put(
        '/location/addCoordinate',
        query: {
          'id': id,
        },
        body: coordinateDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> setVirtualZone(int id, int virtualZoneId) async {
    try {
      final response = await http.put(
        '/location/setVirtualZone',
        query: {
          'id': id,
          'virtualZoneId': virtualZoneId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<LocationEntity> setClassroom(int id, int classroomId) async {
    try {
      final response = await http.put(
        '/location/setClassroom',
        query: {
          'id': id,
          'classroomId': classroomId,
        },
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
      throw UnexpectedApiException();
    }
  }
}
