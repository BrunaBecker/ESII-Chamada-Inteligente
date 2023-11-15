import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _isLoading = true.obs;
  final _usePreset = true.obs;
  final _saveLocation = true.obs;
  final _silentMode = false.obs;

  bool get isLoading => _isLoading.value;

  bool get usePreset => _usePreset.value;

  bool get saveLocation => _saveLocation.value;

  bool get silentMode => _silentMode.value;

  @override
  void onInit() {
    super.onInit();

    _isLoading.value = false;
  }

  void toggleUsePreset() {
    _usePreset.value = !_usePreset.value;
  }

  void toggleSaveLocation() {
    _saveLocation.value = !_saveLocation.value;
  }

  void toggleSilentMode() {
    _silentMode.value = !_silentMode.value;
  }
}
