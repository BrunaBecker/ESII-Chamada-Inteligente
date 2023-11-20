import 'package:get/get.dart';

import 'core/domain/entities/person_entity.dart';

enum UserType { student, professor }

class AppController extends GetxController {
  final _user = Rx<PersonEntity?>(null);
  final _userType = Rx<UserType?>(null);

  // userId getter and setter
  PersonEntity? get user => _user.value;

  set user(PersonEntity? user) => _user.value = user;

  // userType getter and setter
  UserType? get userType => _userType.value;

  set userType(UserType? userType) => _userType.value = userType;

  bool get isProfessor => userType == UserType.professor;
  String get userProfileImage => user?.profileImage?.linkFile ?? "";
}
