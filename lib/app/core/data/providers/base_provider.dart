import '../../adapters/log_adapter.dart';
import '../../enums/ansi_color.dart';
import '../../exceptions/entity_not_found_exception.dart';
import '../../exceptions/no_api_response_exception.dart';

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
      throw NoApiResponseException();
    }

    if (!statusCodes.contains(response.statusCode)) {
      switch (response.statusCode) {
        case 204:
          throw EntityNotFoundException();
        case null:
          throw NoApiResponseException();
      }

      throw Exception("API return status code is not expected.");
    }
  }
}
