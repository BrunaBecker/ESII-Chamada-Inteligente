import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'classroom_dto.dart';
import 'comment_dto.dart';
import 'location_dto.dart';
import 'notification_dto.dart';
import 'picture_dto.dart';
import 'register_professor_dto.dart';
import 'setting_dto.dart';

class ProfessorDto extends ProfessorEntity {
  ProfessorDto({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    super.siape,
    super.setting,
    required super.profileImage,
  });

  factory ProfessorDto.fromEntity(ProfessorEntity entity) {
    return ProfessorDto(
      id: entity.id,
      name: entity.name,
      socialName: entity.socialName,
      birthDate: entity.birthDate,
      isActive: entity.isActive,
      cpf: entity.cpf,
      email: entity.email,
      password: entity.password,
      siape: entity.siape,
      setting: entity.setting,
      profileImage: entity.profileImage,
    );
  }

  factory ProfessorDto.fromMap(Map<String, dynamic> map) {
    // Mapping Comments
    List<CommentDto> comments = [];
    for (var comment in map["comments"]) {
      comments.add(CommentDto.fromMap(comment));
    }
    // Mapping Notifications
    List<NotificationDto> notifications = [];
    for (var notification in map["notifications"]) {
      notifications.add(NotificationDto.fromMap(notification));
    }
    // Mapping Locations
    List<LocationDto> locations = [];
    for (var location in map["locations"]) {
      locations.add(LocationDto.fromMap(location));
    }
    // Mapping Classrooms
    List<ClassroomDto> classrooms = [];
    for (var classroom in map["classrooms"]) {
      classrooms.add(ClassroomDto.fromMap(classroom));
    }

    // Checking non required fields
    RegisterProfessorDto? siape;
    if (map["siape"] != null) {
      siape = RegisterProfessorDto.fromMap(map["siape"]);
    }

    SettingDto? setting;
    if (map["setting"] != null) {
      setting = SettingDto.fromMap(map["setting"]);
    }

    return ProfessorDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: AppDateUtils.storageDateFormat.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      siape: siape,
      setting: setting,
      profileImage: PictureDto.fromMap(map["profileImage"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "socialName": socialName,
      "birthDate": AppDateUtils.storageDateFormat.format(birthDate),
      "isActive": isActive,
      "cpf": cpf,
      "email": email,
      "password": password,
      "siape": siape != null
          ? RegisterProfessorDto.fromEntity(siape as RegisterProfessorDto)
              .toMap()
          : null,
      "setting":
          setting != null ? SettingDto.fromEntity(setting!).toMap() : null,
      "profileImage": profileImage != null
          ? PictureDto.fromEntity(profileImage!).toMap()
          : null,
    };
  }

  factory ProfessorDto.fromJson(String source) =>
      ProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
