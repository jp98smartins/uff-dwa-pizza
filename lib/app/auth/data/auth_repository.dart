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
    // final response = await _client.post(
    //   '/sign-in',
    //   body: credentials.toBody(),
    //   segment: 'Authentication',
    //   step: 'Sign In',
    // );

    // return AuthMapper.fromMap(response.dataAsMap);
    await Future.delayed(const Duration(seconds: 2));
    return AuthMapper.fromMap({
      'user': {
        'id': 1,
        'name': 'João Pedro Martins',
        'phone': '21998109950',
        'email': 'joaopedromartins@id.uff.br',
        'cpf': '15494493709',
        'address': 'Av. Roberto Siveira, 463 - Apt 906',
      },
      'token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIsInJvbGUiOiJBRE1JTiIsInR5cGUiOiJNQU5BR0VSIiwiaWF0IjoxNzMyNTYwMTMwLCJleHAiOjE3MzI1NjM3MzAsImF1ZCI6ImxvY2FsaG9zdDozMDAwIiwiaXNzIjoibG9jYWxob3N0OjMwMDAifQ.5sch2DVbpHOCQh0S85WC3AHs3dARYmWrpW28pu2Cc0Q',
    });
  }

  @override
  Future<void> signUp(ClientUserModel clientUser) async {
    // await _client.post(
    //   '/sign-up',
    //   body: clientUser.toBody(),
    //   segment: 'Authentication',
    //   step: 'Sign Up',
    // );

    await Future.delayed(const Duration(seconds: 2));
  }
}
