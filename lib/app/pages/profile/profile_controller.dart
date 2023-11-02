import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _isLoading = true.obs;
  late final Map<String, dynamic> _user;
  late final bool _isStudent;

  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get user => _user;
  bool get isStudent => _isStudent;

  @override
  void onInit() {
    super.onInit();

    // TODO: differ between student and professor
    _isStudent = false;
    _user = {
      "name": "Nome do usuário",
      "registration": "123456789",
      "email": "email@id.uff.br",
    };

    _isLoading.value = false;
  }
}
