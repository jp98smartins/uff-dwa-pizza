import '../entities/entities.dart';
import 'timeout_options.dart';

/// Class that represents the HTTP methods.
abstract interface class HttpClient {
  /// Method that represents the HTTP's DELETE method.
  Future<AppResponse> delete(
    String endpoint, {
    bool authenticate = false,
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });

  /// Method that represents the HTTP's GET method to download a file.
  Future<AppResponse> download(
    String endpoint,
    String pathToSave, {
    bool authenticate = false,
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });

  /// Method that represents the HTTP's GET method.
  Future<AppResponse> get(
    String endpoint, {
    bool authenticate = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });

  /// Method that represents the HTTP's PATCH method.
  Future<AppResponse> patch(
    String endpoint, {
    bool authenticate = false,
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });

  /// Method that represents the HTTP's POST method.
  Future<AppResponse> post(
    String endpoint, {
    bool authenticate = false,
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });

  /// Method that represents the HTTP's PUT method.
  Future<AppResponse> put(
    String endpoint, {
    bool authenticate = false,
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? replaceBaseUrl,
    String? segment,
    bool? showLogs,
    String? step,
    TimeoutOptions? timeout,
  });
}
