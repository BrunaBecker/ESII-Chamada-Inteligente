import '../../adapters/log_adapter.dart';
import '../../enums/ansi_color.dart';

abstract class BaseProvider {
  void logContent(String message) {
    const color = AnsiColor.blue;
    appLog(
      "++++++++++ PROVIDER CONTENT ++++++++++++++++++++++",
      color: color,
    );
    appLog(
      message,
      color: color,
    );
    appLog(
      "--------------------------------------------------",
      color: color,
    );
  }

  void logError(String message) {
    const color = AnsiColor.red;
    appLog(
      "++++++++++ PROVIDER ERROR ++++++++++++++++++++++++",
      color: color,
    );
    appLog(
      message,
      color: color,
    );
    appLog(
      "--------------------------------------------------",
      color: color,
    );
  }

  void validateResponse({
    required dynamic response,
    List<int> statusCodes = const [200],
  }) {
    if (response == null || response?.data == null) {
      throw Exception("API return is null.");
    }

    if (!statusCodes.contains(response.statusCode)) {
      throw Exception("API return status code is not expected.");
    }
  }
}
