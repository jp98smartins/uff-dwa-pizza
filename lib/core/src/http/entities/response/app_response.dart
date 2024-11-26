import 'dart:convert';

import '../request/app_request.dart';
import 'enums/app_response_type.dart';

export 'enums/app_response_type.dart';
export 'extensions/app_response_extension.dart';

/// Class that represents the response of a HTTP's request.
final class AppResponse<T> {
  /// The status code of the response.
  final int code;

  /// The data of the response.
  final T? data;

  /// The extra data of the response.
  final Map<String, dynamic>? extra;

  /// The headers of the response.
  final Map<String, Object?>? headers;

  /// The request that originated this response.
  final AppRequest request;

  /// The type of the response.
  final AppResponseType type;

  const AppResponse({
    required this.code,
    required this.request,
    required this.type,
    this.data,
    this.extra,
    this.headers,
  });

  Map<String, dynamic> get dataAsMap {
    final data = this.data;
    if (data is Map<String, dynamic>) return Map.from(data);

    if (data is String && type == AppResponseType.json) {
      return Map.from(jsonDecode(data));
    }

    throw Exception('Data cannot be parsed as a json object');
  }
}
