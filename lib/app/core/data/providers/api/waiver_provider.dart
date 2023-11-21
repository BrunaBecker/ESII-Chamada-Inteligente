import '../../../adapters/http_adapter.dart';
import '../../../domain/entities/attendance_status_entity.dart';
import '../../../domain/entities/comment_entity.dart';
import '../../../domain/entities/file_mac_fi_entity.dart';
import '../../../domain/entities/waiver_entity.dart';
import '../../../exceptions/entity_not_found_exception.dart';
import '../../../exceptions/no_api_response_exception.dart';
import '../../../exceptions/unexpected_api_exception.dart';
import '../../dtos/attendance_status_dto.dart';
import '../../dtos/comment_dto.dart';
import '../../dtos/file_mac_fi_dto.dart';
import '../../dtos/waiver_dto.dart';
import '../base_provider.dart';

class WaiverProvider extends BaseProvider {
  Http http;

  WaiverProvider({required this.http});

  Future<WaiverEntity> create(WaiverEntity waiverEntity) async {
    WaiverDto waiverDto = WaiverDto.fromEntity(waiverEntity);

    try {
      final response = await http.post(
        '/waiver',
        body: waiverDto.toMap(),
      );

      validateResponse(
        response: response,
        statusCodes: [201],
      );

      return WaiverDto.fromMap(response.data);
    } on EntityNotFoundException {
      rethrow;
    } on NoApiResponseException {
      rethrow;
    } catch (e) {
      logError(e.toString());
      throw UnexpectedApiException();
    }
  }

  Future<WaiverEntity> fetchByStudentAndClassroom(
      int studentId, int classroomId) async {
    try {
      final response = await http.get('/waiver/byStudentAndClassroom', query: {
        'idStudent': studentId,
        'idClassroom': classroomId,
      });

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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverEntity> fetchById(int waiverId) async {
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
      throw UnexpectedApiException();
    }
  }

  //todo setAttendanceStatus addAttendanceStatus setAccepted setRejected addComment setComment setFile addFile setAcceptionDate
  Future<WaiverEntity> setAttendanceStatus(
      int waiverId, int attendanceStatusId) async {
    try {
      final response = await http.put(
        '/waiver/setAttendanceStatus',
        query: {
          'idWaiver': waiverId,
          'idAttendanceStatus': attendanceStatusId,
        },
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
      throw UnexpectedApiException();
    }
  }
  Future<WaiverEntity> addAttendanceStatus(
        int waiverId, AttendanceStatusEntity attendanceStatusEntity) async {
        AttendanceStatusDto attendanceStatusDto = AttendanceStatusDto.fromEntity(attendanceStatusEntity);
    try {
      final response = await http.put(
        '/waiver/addAttendanceStatus',
        query: {
          'idWaiver': waiverId,
        },
        body: attendanceStatusDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverDto> setAccepted(int waiverId) async { 
    try {
      final response = await http.put(
        '/waiver/setAccepted',
        query: {
          'idWaiver': waiverId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverDto> setRejected(int waiverId) async { 
    try {
      final response = await http.put(
        '/waiver/setRejected',
        query: {
          'idWaiver': waiverId,
        },
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
      throw UnexpectedApiException();
    }
  }
  Future<WaiverDto> addComment(int waiverId, CommentEntity commentEntity) async { 
    CommentDto commentDto = CommentDto.fromEntity(commentEntity);
    try {
      final response = await http.put(
        '/waiver/addComment',
        query: {
          'idWaiver': waiverId,
        },
        body: commentDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }


  Future<WaiverDto> setComment(int waiverId, int commentId) async {
    try {
      final response = await http.put(
        '/waiver/setComment',
        query: {
          'idWaiver': waiverId,
          'idComment': commentId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverDto> setFile(int waiverId, int fileId) async {
    try {
      final response = await http.put(
        '/waiver/setFile',
        query: {
          'idWaiver': waiverId,
          'idFile': fileId,
        },
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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverDto> addFile(int waiverId, FileMacFiEntity fileMacFiEntity) async {
    
    FileMacFiDto fileMacFiDto = FileMacFiDto.fromEntity(fileMacFiEntity);
    
    try {
      final response = await http.put(
        '/waiver/addFile',
        query: {
          'idWaiver': waiverId,
        },
        body: fileMacFiDto.toMap(),
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
      throw UnexpectedApiException();
    }
  }

  Future<WaiverDto> setAcceptionDate(int waiverId, String acceptionDate) async {
    try {
      final response = await http.put(
        '/waiver/setAcceptionDate',
        query: {
          'idWaiver': waiverId,
          'acceptionDate': acceptionDate,
        },
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
      throw UnexpectedApiException();
    }
  }
}
