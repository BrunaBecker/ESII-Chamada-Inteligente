import 'dart:convert';

import '../../domain/entities/register_student_entity.dart';
import '../../domain/entities/student_entity.dart';
import '../../utils/app_date_utils.dart';
import 'attendance_dto.dart';
import 'classroom_dto.dart';
import 'comment_dto.dart';
import 'notification_dto.dart';
import 'register_student_dto.dart';
import 'waiver_dto.dart';

class StudentDto extends StudentEntity {
  StudentDto({
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
    required super.classrooms,
    required super.waivers,
    required super.attendances,
  });

  factory StudentDto.fromEntity(StudentEntity entity) {
    return StudentDto(
      id: entity.id,
      name: entity.name,
      socialName: entity.socialName,
      birthDate: entity.birthDate,
      isActive: entity.isActive,
      cpf: entity.cpf,
      email: entity.email,
      password: entity.password,
      register: entity.register as RegisterStudentEntity,
      setting: entity.setting,
      profileImage: entity.profileImage,
      comments: entity.comments,
      notifications: entity.notifications,
      classrooms: entity.classrooms,
      waivers: entity.waivers,
      attendances: entity.attendances,
    );
  }

  factory StudentDto.fromMap(Map<String, dynamic> map) {
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
    // Mapping classrooms
    final List<ClassroomDto> classrooms = [];
    for (var classroom in map["classrooms"]) {
      classroom = ClassroomDto.fromMap(classroom);
    }
    // Mapping waivers
    final List<WaiverDto> waivers = [];
    for (var waiver in map["waivers"]) {
      waiver = WaiverDto.fromMap(waiver);
    }
    // Mapping attendances
    final List<AttendanceDto> attendances = [];
    for (var attendance in map["attendances"]) {
      attendance = AttendanceDto.fromMap(attendance);
    }

    return StudentDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: AppDateUtils.storageDateFormat.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      register: RegisterStudentDto.fromMap(map["register"]),
      setting: map["setting"],
      profileImage: map["profileImage"],
      comments: comments,
      notifications: notifications,
      classrooms: classrooms,
      waivers: waivers,
      attendances: attendances,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Comments
    final List<Map<String, dynamic>> commentsAsMap = [];
    for (var comment in comments) {
      commentsAsMap.add(CommentDto.fromEntity(comment).toMap());
    }
    // Mapping Notifications
    final List<Map<String, dynamic>> notificationsAsMap = [];
    for (var notification in notifications) {
      notificationsAsMap.add(NotificationDto.fromEntity(notification).toMap());
    }
    // Mapping classrooms
    final List<Map<String, dynamic>> classroomsAsMap = [];
    for (var classroom in classrooms) {
      classroomsAsMap.add(ClassroomDto.fromEntity(classroom).toMap());
    }
    // Mapping waivers
    final List<Map<String, dynamic>> waiversAsMap = [];
    for (var waiver in waivers) {
      waiversAsMap.add(WaiverDto.fromEntity(waiver).toMap());
    }
    // Mapping attendances
    final List<Map<String, dynamic>> attendancesAsMap = [];
    for (var attendance in attendances) {
      attendancesAsMap.add(AttendanceDto.fromEntity(attendance).toMap());
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
      "register": RegisterStudentDto.fromEntity(register as RegisterStudentDto).toMap(),
      "setting": setting,
      "profileImage": profileImage,
      "comments": commentsAsMap,
      "notifications": notificationsAsMap,
      "classrooms": classroomsAsMap,
      "waivers": waiversAsMap,
      "attendances": attendancesAsMap,
    };
  }

  factory StudentDto.fromJson(String source) => StudentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
