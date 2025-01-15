import 'dart:async';

import '../../../../data/data.dart';

/// Class that handles the http request's authorization.
final class AuthorizationOptions {
  /// The repository that knows how to perform the tokens operations.
  final CoreRepository coreRepository;

  const AuthorizationOptions({required this.coreRepository});

  /// Method that adds the authorization tokens on the request.
  Future<String> readAuthorizationToken() async {
    final auth = await coreRepository.readAuthLocally();
    if (auth == null) return '';
    return 'Bearer ${auth.token.value}';
  }
}
