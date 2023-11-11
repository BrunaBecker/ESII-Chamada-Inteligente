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
    required super.register,
    required super.setting,
    required super.profileImage,
    required super.comments,
    required super.notifications,
    required super.locations,
    required super.classrooms,
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
      register: entity.register,
      setting: entity.setting,
      profileImage: entity.profileImage,
      comments: entity.comments,
      notifications: entity.notifications,
      locations: entity.locations,
      classrooms: entity.classrooms,
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

    return ProfessorDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: AppDateUtils.storageDateFormat.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      register: RegisterProfessorDto.fromMap(map["siape"]),
      setting: SettingDto.fromMap(map["setting"]),
      profileImage: PictureDto.fromMap(map["profileImage"]),
      comments: comments,
      notifications: notifications,
      locations: locations,
      classrooms: classrooms,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Comments
    List<Map<String, dynamic>> commentsAsMap = [];
    for (var comment in comments) {
      commentsAsMap.add(CommentDto.fromEntity(comment).toMap());
    }
    // Mapping Notifications
    List<Map<String, dynamic>> notificationsAsMap = [];
    for (var notification in notifications) {
      notificationsAsMap.add(NotificationDto.fromEntity(notification).toMap());
    }
    // Mapping Locations
    List<Map<String, dynamic>> locationsAsMap = [];
    for (var location in locations) {
      locationsAsMap.add(LocationDto.fromEntity(location).toMap());
    }
    // Mapping Classrooms
    List<Map<String, dynamic>> classroomsAsMap = [];
    for (var classroom in classrooms) {
      classroomsAsMap.add(ClassroomDto.fromEntity(classroom).toMap());
    }

    return {
      "id": id,
      "name": name,
      "socialName": socialName,
      "birthDate": AppDateUtils.storageDateFormat.format(birthDate),
      "isActive": isActive,
      "cpf": cpf,
      "email": email,
      "password": password,
      "register":
          RegisterProfessorDto.fromEntity(register as RegisterProfessorDto)
              .toMap(),
      "setting": SettingDto.fromEntity(setting).toMap(),
      "profileImage": PictureDto.fromEntity(profileImage).toMap(),
      "comments": commentsAsMap,
      "notifications": notificationsAsMap,
      "locations": locationsAsMap,
      "classrooms": classroomsAsMap,
    };
  }

  factory ProfessorDto.fromJson(String source) =>
      ProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
