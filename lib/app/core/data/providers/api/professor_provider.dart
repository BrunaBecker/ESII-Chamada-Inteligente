import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/classroom_entity.dart';
import '../../../domain/entities/comment_entity.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/entities/picture_entity.dart';
import '../../../domain/entities/professor_entity.dart';
import '../../../domain/entities/setting_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/classroom_dto.dart';
import '../../dtos/comment_dto.dart';
import '../../dtos/location_dto.dart';
import '../../dtos/notification_dto.dart';
import '../../dtos/picture_dto.dart';
import '../../dtos/professor_dto.dart';
import '../../dtos/setting_dto.dart';
import '../base_provider.dart';

class ProfessorProvider extends BaseProvider {
  Http http;

  ProfessorProvider({required this.http});

  Future<List<ProfessorEntity>> fetchAll() async {
    try {
      final response = await http.get(
        '/professor',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      final professors = response.data
          .map<ProfessorDto>(
            (professor) => ProfessorDto.fromMap(professor),
          )
          .toList();

      return professors;
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> create(ProfessorEntity professorEntity) async {
    ProfessorDto professorDto = ProfessorDto.fromEntity(professorEntity);
    try {
      final response = await http.post(
        '/professor',
        body: professorDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> update(ProfessorEntity professorEntity) async {
    ProfessorDto professorDto = ProfessorDto.fromEntity(professorEntity);

    try {
      final response = await http.put(
        '/professor',
        body: professorDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> addClassroom(
      String professorIdentifier, ClassroomEntity classroomEntity) async {
    ClassroomDto classroomDto = ClassroomDto.fromEntity(classroomEntity);

    try {
      final response = await http.put(
        '/professor/$professorIdentifier/class',
        body: classroomDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }
  Future<ProfessorEntity> fetchById(int id) async {
    try {
      final response = await http.get(
        '/professor/$id',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> fetchByRegister(int identifier) async {
    try {
      final response = await http.get(
        '/professor/byIdentifier/$identifier',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> fetchByClassroomCode(String classroomCode) async {
    try {
      final response = await http.get(
        '/professor/byClassroomCode/$classroomCode',
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  //todo setClassroom setLocation addLocation  setSetting addSetting setProfileImage addProfileImage addComment setComment addNotification setNotification 
  //
  Future<ProfessorEntity> setClassroom(
      int id, int classroomId) async {
    try {
      final response = await http.put(
        '/professor/setClassroom?',
        query: {
          'id': id,
          'classroomId': classroomId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> setLocation(
      int id, int locationId) async {
    try {
      final response = await http.put(
        '/professor/setLocation?',
        query: {
          'id': id,
          'locationId': locationId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> addLocation(int id, LocationEntity locationEntity) async {
    LocationDto locationDto = LocationDto.fromEntity(locationEntity);

    try {
      final response = await http.put(
        '/professor/addLocation?',
        query: {
          'id': id,
        },
        body: locationDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> setSetting(int id, int settingId) async {
    try {
      final response = await http.put(
        '/professor/setSetting?',
        query: {
          'id': id,
          'settingId': settingId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> addSetting(int id, SettingEntity settingEntity) async {
    SettingDto settingDto = SettingDto.fromEntity(settingEntity);
    try {
      final response = await http.put(
        '/professor/addSetting?',
        query: {
          'id': id,
        },
        body: settingDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }


  Future<ProfessorEntity> setProfileImage(int id, int pictureId) async {
    try {
      final response = await http.put(
        '/professor/setProfileImage?',
        query: {
          'id': id,
          'pictureId': pictureId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }

  }

  Future<ProfessorEntity> addProfileImagem(int id, PictureEntity pictureEntity) async {
    
    PictureDto pictureDto = PictureDto.fromEntity(pictureEntity);
    try {
      final response = await http.put(
        '/professor/addProfileImage?',
        query: {
          'id': id,
        },
        body: pictureDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch(e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> addComment(int id, CommentEntity commentEntity) async {
    CommentDto commentDto = CommentDto.fromEntity(commentEntity);
    
    try {
      final response = await http.put(
        '/professor/addComment?',
        query: {
          'id': id,
        },
        body: commentDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch(e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }


  Future<ProfessorEntity> setComment(int id, int commentId) async {
    try {
      final response = await http.put(
        '/professor/setComment?',
        query: {
          'id': id,
          'commentId': commentId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch(e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> addNotification(int id, NotificationEntity notificationEntity) async {
    NotificationDto notificationDto = NotificationDto.fromEntity(notificationEntity);
    
    try {
      final response = await http.put(
        '/professor/addNotification?',
        query: {
          'id': id,
        },
        body: notificationDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch(e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<ProfessorEntity> setNotification(int id, int notificationId) async {
    try {
      final response = await http.put(
        '/professor/setNotification?',
        query: {
          'id': id,
          'notificationId': notificationId,
        },
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return ProfessorDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch(e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

}
