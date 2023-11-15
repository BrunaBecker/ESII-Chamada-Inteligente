import 'package:get/get.dart';

enum UserType { student, professor }

class AppController extends GetxController {
  final _userId = Rx<int?>(null);
  final _userType = Rx<UserType?>(null);

  // userId getter and setter
  int? get userId => _userId.value;

  set userId(int? userId) => _userId.value = userId;

  // userType getter and setter
  UserType? get userType => _userType.value;

  set userType(UserType? userType) => _userType.value = userType;
}
