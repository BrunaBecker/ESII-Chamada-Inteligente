import '../../../adapters/http_adapter.dart';
import '../base_provider.dart';

class BaseApiProvider<T> extends BaseProvider {
  Http http;

  BaseApiProvider({required this.http});

  Future<T?> create(T entity) async {
    String typeToString = T.toString();
    typeToString = typeToString[0].toLowerCase() + typeToString.substring(1);

    try {
      final response = await http.post(
        '/$typeToString',
        body: entity,
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }

  Future<T?> update(T entity) async {
    String typeToString = T.toString();
    typeToString = typeToString[0].toLowerCase() + typeToString.substring(1);

    try {
      final response = await http.put(
        '/$typeToString',
        body: entity,
      );

      validateResponse(
        response: response,
        statusCodes: [200],
      );

      return response.data;
    } catch (e) {
      logError(e.toString());
    }
    return null;
  }
}
