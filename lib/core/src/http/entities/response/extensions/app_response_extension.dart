import 'package:dio/dio.dart' as dio;

import '../../request/app_request.dart';
import '../app_response.dart';
import 'app_response_type_extension.dart';

extension AppResponseExtension<T> on dio.Response<T> {
  /// Converts a Dio's response to a AppResponse.
  AppResponse<T> toAppResponse() {
    return AppResponse<T>(
      code: statusCode ?? -1,
      data: data,
      extra: extra,
      headers: headers.map,
      request: requestOptions.toAppRequest(),
      type: requestOptions.responseType.toAppResponseType(),
    );
  }
}
