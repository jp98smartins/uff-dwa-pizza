import 'dart:async';

import 'package:dio/dio.dart' as dio;

import '../injector/app_injector.dart';
import '../uuid/app_uuid.dart';
import 'entities/entities.dart';
import 'interceptors/authorization/authorization_interceptor.dart';
import 'interceptors/logger_interceptor.dart';
import 'interfaces/interfaces.dart';
import 'options/options.dart';

export 'package:dio/dio.dart';
export 'package:http_parser/http_parser.dart';

export 'entities/entities.dart';
export 'interceptors/interceptors.dart';
export 'interfaces/interfaces.dart';
export 'options/options.dart';

/// Class that implements [HttpClient] using [dio.Dio].
final class AppHttpClient implements HttpClient {
  /// Options for adding the authorization tokens on the requests.
  final AuthorizationOptions? authorization;

  /// Instance of [dio.Dio] that will be used to make the requests.
  final dio.Dio _dio;

  /// List of interceptors to be added to the [dio.Dio] instance.
  final List<dio.Interceptor>? interceptors;

  /// Flag that indicates if the logs should be shown.
  final bool showLogs;

  AppHttpClient(
    String baseUrl, {
    this.authorization,
    this.interceptors,
    this.showLogs = false,
    TimeoutOptions? timeout,
  }) : _dio = dio.Dio(
          dio.BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: timeout?.connectTimeout ?? AppTimeouts().connectTimeout,
            receiveTimeout: timeout?.receiveTimeout ?? AppTimeouts().receiveTimeout,
            sendTimeout: timeout?.sendTimeout ?? AppTimeouts().sendTimeout,
          ),
        ) {
    addInterceptors();
  }

  /// Add interceptors to the [dio.Dio] instance.
  void addInterceptors() {
    _dio.interceptors.addAll([
      if (authorization != null) ...{
        AuthorizationInterceptor(authorization!),
      },
      if (showLogs) ...{
        LoggerInterceptor(),
      },
    ]);

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  @override
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
  }) {
    return _dio
        .delete(
          endpoint,
          data: body,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
            sendTimeout: body != null ? timeout?.sendTimeout : null,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }

  @override
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
  }) {
    return _dio
        .download(
          endpoint,
          pathToSave,
          data: body,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
            sendTimeout: body != null ? timeout?.sendTimeout : null,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }

  @override
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
  }) {
    return _dio
        .get(
          endpoint,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }

  @override
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
  }) {
    return _dio
        .patch(
          endpoint,
          data: body,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
            sendTimeout: body != null ? timeout?.sendTimeout : null,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }

  @override
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
  }) {
    return _dio
        .post(
          endpoint,
          data: body,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
            sendTimeout: body != null ? timeout?.sendTimeout : null,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }

  @override
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
  }) {
    return _dio
        .put(
          endpoint,
          data: body,
          queryParameters: queryParameters,
          options: dio.Options(
            headers: headers,
            extra: {
              'authorization': authenticate,
              'segment': segment,
              'showLogs': showLogs ?? this.showLogs,
              'step': step,
              'pizza-identifier': AppInjector.get<AppUuid>().generate(),
            },
            receiveTimeout: timeout?.receiveTimeout,
            sendTimeout: body != null ? timeout?.sendTimeout : null,
          ),
        )
        .then<AppResponse>((r) => r.toAppResponse())
        .catchError(AppExceptionHandler.handle);
  }
}
