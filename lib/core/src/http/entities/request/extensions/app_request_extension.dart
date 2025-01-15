import 'package:dio/dio.dart' as dio;

import '../app_request.dart';

extension AppRequestExtension<T> on dio.RequestOptions {
  /// Converts a Dio's response to a AppRequest.
  AppRequest toAppRequest() {
    return AppRequest(
      baseUrl: baseUrl,
      body: data,
      extra: extra,
      headers: headers,
      method: method,
      path: path,
      queryParameters: queryParameters,
      segment: extra['segment'],
      step: extra['step'],
    );
  }
}
