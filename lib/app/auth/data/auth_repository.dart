import '../../../core/core.dart';
import '../domain/models/account_model.dart';
import '../domain/models/credentials_model.dart';

abstract interface class AuthRepository {
  Future<AuthEntity> signIn(CredentialsModel credentials);

  Future<void> signUp(ClientUserModel clientUser);
}

final class AuthRepositoryImpl implements AuthRepository {
  final HttpClient _client;

  const AuthRepositoryImpl(this._client);

  @override
  Future<AuthEntity> signIn(CredentialsModel credentials) async {
    final response = await _client.post(
      '/auth/sign-in',
      body: credentials.toBody(),
      segment: 'Authentication',
      step: 'Sign In',
    );

    return AuthMapper.fromMap(response.dataAsMap);
  }

  @override
  Future<void> signUp(ClientUserModel clientUser) async {
    await _client.post(
      '/auth/sign-up',
      body: clientUser.toBody(),
      segment: 'Authentication',
      step: 'Sign Up',
    );
  }
}
