import '../../domain/entities/auth_entity.dart';
import '../../storages/app_secure_storage.dart';
import '../mappers/auth_mapper.dart';

abstract base class CoreRepository {
  Future<void> clearAuth();

  Future<AuthEntity?> readAuthLocally();

  Future<void> saveAuthLocally(AuthEntity tokens);
}

final class CoreRepositoryImpl implements CoreRepository {
  final SecureStorage _secureStorage;

  const CoreRepositoryImpl(this._secureStorage);

  static const tokensStorageKey = 'b8b2d7cd-0c33-47ba-9a73-a1a4025aec39';

  @override
  Future<void> clearAuth() {
    return _secureStorage.clear(tokensStorageKey);
  }

  @override
  Future<AuthEntity?> readAuthLocally() async {
    final response = await _secureStorage.read(tokensStorageKey);
    if (response == null) return null;
    return AuthMapper.fromJson(response);
  }

  @override
  Future<void> saveAuthLocally(AuthEntity tokens) {
    return _secureStorage.save(tokensStorageKey, AuthMapper.toJson(tokens));
  }
}
