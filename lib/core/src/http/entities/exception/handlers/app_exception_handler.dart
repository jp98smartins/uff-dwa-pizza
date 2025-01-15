import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../domain/domain.dart';
import '../../entities.dart';

final class AppExceptionHandler {
  static Future<AppResponse> handle(Object error) async {
    Object exception = error;

    if (error is DioException) {
      if (error.response == null) {
        exception = AppException.network(
          segment: error.requestOptions.extra['segment'] as String?,
          step: error.requestOptions.extra['step'] as String?,
        );
      }

      final statusCode = error.response?.statusCode ?? -1;

      if (statusCode > 399 && statusCode < 500) {
        exception = AppException.business(
          AppExceptionTags.parse(error.response!.data['tag'].toString()),
          segment: error.requestOptions.extra['segment'] as String?,
          step: error.requestOptions.extra['step'] as String?,
        );
      }

      if (statusCode > 499) {
        exception = AppException.unexpected(
          segment: error.requestOptions.extra['segment'] as String?,
          step: error.requestOptions.extra['step'] as String?,
        );
      }
    }

    throw exception;
  }
}
