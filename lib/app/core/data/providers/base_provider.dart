import '../../adapters/log_adapter.dart';
import '../../enums/ansi_color.dart';
import '../../exceptions/entity_not_found_exception.dart';
import '../../exceptions/no_api_response_exception.dart';

abstract class BaseProvider {
  void logContent(String message) {
    const color = AnsiColor.blue;
    message = ""
        "++++++++++ PROVIDER CONTENT ++++++++++++++++++++++\n"
        "$message\n"
        "--------------------------------------------------\n";
    appLog(
      message,
      color: color,
    );
  }

  void logError(String message) {
    const color = AnsiColor.red;
    message = ""
        "++++++++++ PROVIDER ERROR ++++++++++++++++++++++++\n"
        "$message\n"
        "--------------------------------------------------\n";
    appLog(
      message,
      color: color,
    );
  }

  void validateResponse({
    required dynamic response,
    List<int> statusCodes = const [200, 201],
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
