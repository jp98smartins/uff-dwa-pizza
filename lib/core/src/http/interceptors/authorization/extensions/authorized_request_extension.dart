import 'package:dio/dio.dart' as dio;

extension AuthorizedRequestExtension on dio.RequestOptions {
  bool get needsAuthorization => extra['authorization'] ?? false;

  void authorizeRequest() => extra['authorization'] = true;
}
