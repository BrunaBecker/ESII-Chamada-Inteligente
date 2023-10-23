import 'package:get/get.dart';

class StudentInfoController extends GetxController {
  final _isLoading = true.obs;
  late final Map<String, dynamic> _selectedStudent;
  late final Map<String, dynamic> _selectedClass;

  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get selectedStudent => _selectedStudent;
  Map<String, dynamic> get selectedClass => _selectedClass;

  @override
  void onReady() async {
    _isLoading.value = true;

    _selectedStudent = Get.arguments["studentInfo"];
    _selectedClass = Get.arguments["classInfo"];

    _isLoading.value = false;
    super.onReady();
  }
}
