import '../../../../core/core.dart';
import '../domain/models/admin_user_model.dart';

abstract interface class AdminUserRepository {
  Future<void> deleteUser(int id);

  Future<AdminUserByTypeModel> getUsers();

  Future<void> postUser(AdminUserModel user);
}

final class AdminUserRepositoryImpl implements AdminUserRepository {
  final HttpClient _client;

  const AdminUserRepositoryImpl(this._client);

  @override
  Future<void> deleteUser(int id) async {
    await _client.delete(
      '/auth/users/$id',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'User',
      step: 'Delete User',
    );
  }

  @override
  Future<AdminUserByTypeModel> getUsers() async {
    final response = await _client.get(
      '/auth/users',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Users',
      step: 'Get Users',
    );

    return AdminUserByTypeModel.fromMap(response.dataAsMap);
  }

  @override
  Future<void> postUser(AdminUserModel user) async {
    await _client.post(
      '/auth/users/admins',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      body: user.toMap(),
      segment: 'User',
      step: 'Post User (Admin)',
    );
  }
}
