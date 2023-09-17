import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isVisible = false.obs;

  bool get isVisible => _isVisible.value;

  void togglePasswordVisibility() {
    _isVisible.value = !_isVisible.value;
  }
}
