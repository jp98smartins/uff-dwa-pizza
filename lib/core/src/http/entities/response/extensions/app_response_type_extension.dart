import 'package:dio/dio.dart' as dio;

import '../app_response.dart';

extension AppResponseTypeExtension on dio.ResponseType {
  AppResponseType toAppResponseType() => switch (this) {
        dio.ResponseType.bytes => AppResponseType.bytes,
        dio.ResponseType.json => AppResponseType.json,
        dio.ResponseType.plain => AppResponseType.plain,
        dio.ResponseType.stream => AppResponseType.stream,
      };
}
