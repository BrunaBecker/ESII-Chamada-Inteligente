import 'dart:convert';

import 'package:dio/dio.dart';

import '../constants.dart';
import '../enums/ansi_color.dart';
import 'log_adapter.dart';

abstract class Http {
  Future<dynamic> delete(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  Future<dynamic> get(
    dynamic endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  Future<dynamic> getBytes(
    dynamic endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  Future<dynamic> patch(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  Future<dynamic> post(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  Future<dynamic> put(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });
}

class HttpAdapter extends Interceptor implements Http {
  HttpAdapter() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          try {
            var message = "++++++++++ API REQUEST +++++++++++++++++++++++++++\n"
                "Method: ${request.method}\n"
                "Path: ${request.path}\n"
                "Base URL: ${request.baseUrl}\n"
                "URI: ${request.uri}\n"
                "Headers: ${request.headers.toString()}\n"
                "Query Params: ${request.queryParameters.toString()}\n"
                "Body: ${jsonEncode(request.data)}\n"
                "---------- API REQUEST ---------------------------";
            appLog(message, color: AnsiColor.lightBlue);
          } catch (_) {}
          handler.next(request);
        },
        onResponse: (response, handler) {
          try {
            var message = "++++++++++ API RESPONSE ++++++++++++++++++++++++++\n"
                "Status Code: ${response.statusCode}\n"
                "Data: ${jsonEncode(response.data)}\n"
                "---------- API RESPONSE --------------------------";
            appLog(message, color: AnsiColor.green);
          } catch (_) {}
          handler.next(response);
        },
        onError: (dioError, handler) async {
          try {
            var message = "++++++++++ API ERROR +++++++++++++++++++++++++++++\n"
                "request: ${dioError.requestOptions.uri}\n"
                "Status Code: ${dioError.response?.statusCode}\n"
                "Data: ${dioError.response != null ? jsonEncode(dioError.response!.data) : "null"}\n"
                "message: ${dioError.message}\n"
                "message: ${dioError.error}\n"
                "---------- API ERROR -----------------------------";
            appLog(message, color: AnsiColor.red);
          } catch (_) {}
          handler.next(await errorHandler(dioError));
        },
      ),
    );
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: httpTimeout,
      receiveTimeout: httpTimeout,
      sendTimeout: httpTimeout,
    ),
  );

  static final List<DioExceptionType> _dioErrorTimeoutList = [
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.sendTimeout,
  ];

  Future<DioException> errorHandler(DioException dioException) async {
    if (_dioErrorTimeoutList.contains(dioException.type)) {
      dioException.error;
      return dioException;
    }

    if (dioException.response != null) {
      switch (dioException.response!.statusCode) {
        // Unauthorized Error
        case 401:
          return dioExceptionNewMessage(
            dioException: dioException,
            message: httpUnauthorizedErrorMessage,
          );
        // Server Error
        case 500:
          return dioExceptionNewMessage(
            dioException: dioException,
            message: httpServerErrorMessage,
          );
        default:
          return dioException;
      }
    }

    // No Connection Error
    return dioExceptionNewMessage(
      dioException: dioException,
      message: httpNoConnectionErrorMessage,
    );
  }

  Future<dynamic> requestWithRetry(
    Future<dynamic> Function() request, {
    int maxRetries = maxRetries,
    int? delayBetweenRetry,
  }) async {
    try {
      // First attempt
      return await request();
    } on DioException catch (dioError) {
      if (dioError.response == null) {
        for (int i = 0; i < maxRetries; i++) {
          try {
            // Delay between attempts
            await Future.delayed(const Duration(
              milliseconds: retryDelay,
            ));

            // Retry request
            return await request();
          } on DioException catch (_) {}
        }
      }

      if ([401, 500].contains(dioError.response?.statusCode)) {
        rethrow;
      } else {
        return dioError.response;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.delete(
        endpoint,
        data: body,
        queryParameters: query,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  @override
  Future<dynamic> get(
    dynamic endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.get(
        endpoint,
        queryParameters: query,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  @override
  Future<dynamic> getBytes(
    dynamic endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.get(
        endpoint,
        queryParameters: query,
        options: Options(
          headers: headers,
          responseType: ResponseType.bytes,
        ),
      ),
    );
  }

  @override
  Future<dynamic> post(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.post(
        endpoint,
        data: body,
        queryParameters: query,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  @override
  Future<dynamic> put(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.put(
        endpoint,
        data: body,
        queryParameters: query,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  @override
  Future<dynamic> patch(
    dynamic endpoint, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    return await requestWithRetry(
      () => dio.patch(
        endpoint,
        data: body,
        queryParameters: query,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }
}

DioException dioExceptionNewMessage({
  required DioException dioException,
  required String message,
}) {
  return DioException(
    requestOptions: dioException.requestOptions,
    response: dioException.response,
    type: dioException.type,
    error: message,
  );
}
