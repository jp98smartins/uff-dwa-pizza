import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../injector/app_injector.dart';
import 'extensions/authorized_request_extension.dart';
import 'options/authorization_options.dart';

export 'options/authorization_options.dart';

/// A [dio.Interceptor] that adds the authorization tokens on the request.
final class AuthorizationInterceptor extends dio.Interceptor {
  /// Options to add the authorization tokens on the request.
  final AuthorizationOptions authorization;

  AuthorizationInterceptor(this.authorization);

  /// A [JsonEncoder] that indents the JSON output.
  final _encoder = const JsonEncoder.withIndent('  ');

  /// Converts the [dio.FormData] to a [Map].
  Map<String, String> formDataToMap(dio.FormData formData) {
    final map = <String, String>{};
    formData.fields.map((field) => map[field.key] = field.value);
    formData.files.map((file) => map[file.key] = file.value.filename ?? 'File');
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

  Future<void> _addHeaderAuthorizationToken(dio.RequestOptions options) async {
    final accessToken = await authorization.readAuthorizationToken();
    options.headers['Authorization'] = accessToken;
  }

  /// Adds the authorization token on the request.
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) async {
    if (options.needsAuthorization) {
      await _addHeaderAuthorizationToken(options);
    }

    handler.next(options);
  }

  /// Refreshes the authorization token if it is invalid.
  @override
  void onError(
    dio.DioException exception,
    dio.ErrorInterceptorHandler handler,
  ) async {
    if (exception.requestOptions.needsAuthorization && exception.response?.statusCode == 403) {
      final navKey = AppInjector.get<GlobalKey<NavigatorState>>();
      navKey.currentContext?.go('/', extra: 'UNAUTHORIZED');
      return handler.reject(exception);
    }

    handler.next(exception);
  }
}
