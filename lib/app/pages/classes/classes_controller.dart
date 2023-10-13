import 'package:get/get.dart';

class ClassesController extends GetxController {
  final _isLoading = false.obs;
  final _classesList = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;
  List<Map<String, dynamic>> get classesList => _classesList;

  @override
  void onReady() {
    _isLoading.value = true;
    // TODO: get classes
    for (var i = 1; i < 21; i++) {
      classesList.add({
        "code": "TCC00${291 + i}",
        "name": "Engenharia de Software $i",
        "class": "A1",
        "activeAttendance": false,
      });
    }
    classesList[0]["activeAttendance"] = true;
    classesList[1]["activeAttendance"] = true;

    _isLoading.value = false;
    super.onReady();
  }

  void toggleAttendance(int index) {
    classesList[index]["activeAttendance"] = !classesList[index]["activeAttendance"]!;
    update();
  }
}
