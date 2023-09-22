import 'package:get/get.dart';

class ClassesController extends GetxController {
  final _isLoading = false.obs;
  final _classesList = <Map<String, String>>[].obs;

  bool get isLoading => _isLoading.value;
  List<Map<String, String>> get classesList => _classesList;

  @override
  void onReady() {
    _isLoading.value = true;
    // TODO: get classes
    for (var i = 1; i < 21; i++) {
      _classesList.add({
        "code": "TCC00${291 + i}",
        "name": "Engenharia de Software $i",
        "class": "A1",
      });
    }

    _isLoading.value = false;
    super.onReady();
  }
}
