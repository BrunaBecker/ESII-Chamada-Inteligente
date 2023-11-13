import 'package:get/get.dart';

class DailyWarningsController extends GetxController {
  final _isLoading = true.obs;
  late final DateTime _day;
  final _events = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;

  DateTime get day => _day;

  List<Map<String, dynamic>> get events => _events;

  @override
  void onReady() async {
    super.onReady();

    _day = Get.arguments["day"];
    _events.addAll(Get.arguments["events"]);

    _isLoading.value = false;
  }
}
