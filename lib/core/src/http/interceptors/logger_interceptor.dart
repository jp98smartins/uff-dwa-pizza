// Copyright 2024 UFF

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../../logger/app_logger.dart';

/// A [dio.Interceptor] that logs the exceptions/erros, requests, and responses.
final class LoggerInterceptor extends dio.Interceptor {
  /// A [JsonEncoder] that indents the JSON output.
  final _encoder = const JsonEncoder.withIndent('  ');

  /// A [Logger] that logs the exceptions/erros, requests, and responses.
  final _logger = AppLogger();

  /// Converts the [dio.FormData] to a [Map].
  Map<String, String> formDataToMap(dio.FormData formData) {
    final map = <String, String>{};
    formData.fields.map((field) => map[field.key] = field.value);
    formData.files.map((file) {
      map[file.key] = file.value.filename ?? 'File';
    });
    return map;
  }

  String logDataFormat(String data) => data.replaceAll('\n', '\n║  ');

  /// Parses the body data.
  String parseBodyData(dynamic data) {
    final bodyDataFormated = switch (data) {
      String() => _encoder.convert(jsonDecode(data)),
      Map() => _encoder.convert(data),
      dio.FormData() => _encoder.convert(formDataToMap(data)),
      _ => data.toString(),
    };
    return logDataFormat(bodyDataFormated);
  }

  /// Parses the headers data.
  String parseHeadersData(Map<String, dynamic> data) {
    final bodyDataFormated = _encoder.convert(data);
    return logDataFormat(bodyDataFormated);
  }

  /// Parses the Query Params data.
  String parseQueryParamsData(Map<String, dynamic> data) {
    final bodyDataFormated = _encoder.convert(data);
    return logDataFormat(bodyDataFormated);
  }

  /// Logs the Requests.
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    if (options.extra['showLogs'] ?? false) {
      _logger.logInfo(
        '''
╔════════════════╣ A HttpRequest was sent!
║  [ HttpRequest ] - Date and Time    | ${DateTime.now()}
║  [ HttpRequest ] - Identifier       | ${options.extra['pizza-identifier']}
║  [ HttpRequest ] - Method           | ${options.method.toUpperCase()}
║  [ HttpRequest ] - Base URL         | ${options.baseUrl}
║  [ HttpRequest ] - Endpoint         | ${options.path}
║  [ HttpRequest ] - Query Params     | ${parseQueryParamsData(options.queryParameters)}
║  [ HttpRequest ] - Headers          | ${parseHeadersData(options.headers)}
║  [ HttpRequest ] - Body             | ${parseBodyData(options.data)}
║  [ HttpRequest ] - Segment          | ${options.extra['segment']}
║  [ HttpRequest ] - Step             | ${options.extra['step']}
╚══════════════════════════════════''',
      );
    }

    return handler.next(options);
  }

  /// Logs the Responses.
  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.extra['showLogs'] ?? false) {
      _logger.logSuccess(
        '''
╔═════════════════╣ A HttpResponse was received!
║  [ HttpResponse ] - Date and Time   | ${DateTime.now()}
║  [ HttpResponse ] - Identifier      | ${response.requestOptions.extra['pizza-identifier']}
║  [ HttpResponse ] - Method          | ${response.requestOptions.method.toUpperCase()}
║  [ HttpResponse ] - Base URL        | ${response.requestOptions.baseUrl}
║  [ HttpResponse ] - Endpoint        | ${response.requestOptions.path}
║  [ HttpResponse ] - Status Code     | ${response.statusCode}
║  [ HttpResponse ] - Status Message  | ${response.statusMessage}
║  [ HttpResponse ] - Headers         | ${parseHeadersData(response.headers.map)}
║  [ HttpResponse ] - Data            | ${parseBodyData(response.data)}
║  [ HttpResponse ] - Segment         | ${response.requestOptions.extra['segment']}
║  [ HttpResponse ] - Step            | ${response.requestOptions.extra['step']}
╚════════════════════════════════════''',
      );
    }

    return handler.next(response);
  }

  /// Logs the Exceptions/Errors.
  @override
  void onError(
    dio.DioException err,
    dio.ErrorInterceptorHandler handler,
  ) {
    if (err.requestOptions.extra['showLogs'] ?? false) {
      _logger.logError(
        '''
╔════════════════╣ A ${err.type} was thrown!
║  [ ${err.type} ] - Date and Time  | ${DateTime.now()}
║  [ ${err.type} ] - Identifier     | ${err.requestOptions.extra['pizza-identifier']}
║  [ ${err.type} ] - Base URL       | ${err.requestOptions.baseUrl}
║  [ ${err.type} ] - Endpoint       | ${err.requestOptions.path}
║  [ ${err.type} ] - Query Params   | ${parseQueryParamsData(err.requestOptions.queryParameters)}
║  [ ${err.type} ] - Headers        | ${parseHeadersData(err.requestOptions.headers)}
║  [ ${err.type} ] - Data           | ${parseBodyData(err.response?.data)}
║  [ ${err.type} ] - Segment        | ${err.requestOptions.extra['segment']}
║  [ ${err.type} ] - Step           | ${err.requestOptions.extra['step']}
║  [ ${err.type} ] - Status Code    | ${err.response?.statusCode}
║  [ ${err.type} ] - Status Message | ${err.response?.statusMessage}
╚══════════════════════════════════''',
      );
    }

    return handler.next(err);
  }
}
