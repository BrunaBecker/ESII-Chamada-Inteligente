import 'comment_entity.dart';
import 'notification_entity.dart';
import 'picture_entity.dart';
import 'register_college_id_entity.dart';
import 'setting_entity.dart';

abstract class PersonEntity {
  PersonEntity({
    required this.id,
    required this.name,
    required this.socialName,
    required this.birthDate,
    required this.isActive,
    required this.cpf,
    required this.email,
    required this.password,
    required this.register,
    required this.setting,
    required this.profileImage,
    required this.comments,
    required this.notifications,
  });

  int id;
  String name;
  String socialName;
  DateTime birthDate;
  bool isActive;
  String cpf;
  String email;
  String password;
  RegisterCollegeIdEntity register;
  SettingEntity setting;
  PictureEntity profileImage;
  List<CommentEntity> comments;
  List<NotificationEntity> notifications;
}
