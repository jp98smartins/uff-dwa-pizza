export 'extensions/app_request_extension.dart';

/// Class that represents the HTTP's request.
final class AppRequest {
  /// The base URL of the request.
  final String baseUrl;

  /// The data of the response.
  final dynamic body;

  /// The extra data of the request.
  final Map<String, dynamic>? extra;

  /// The headers of the request.
  final Map<String, dynamic>? headers;

  /// The method of the request.
  final String method;

  /// The path of the request.
  final String path;

  /// The query parameters of the request.
  final Map<String, dynamic>? queryParameters;

  /// Optional description of the module/service that the request is supposed to hit.
  final String? segment;

  /// Optional description of what the request is supposed to do.
  final String? step;

  const AppRequest({
    required this.baseUrl,
    required this.method,
    required this.path,
    this.body,
    this.extra,
    this.headers,
    this.queryParameters,
    this.segment,
    this.step,
  });
}
