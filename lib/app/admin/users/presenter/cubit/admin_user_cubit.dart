import '../../../../../core/core.dart';
import '../../data/admin_user_repository.dart';
import '../../domain/models/admin_user_model.dart';

part 'admin_user_states.dart';

final class AdminUserCubit extends Cubit<AdminUserState> {
  final AdminUserRepository _adminUserRepository;

  AdminUserCubit(
    this._adminUserRepository,
  ) : super(AdminUserLoading());

  Future<void> createUser(AdminUserModel user) async {
    emit(AdminUserLoading());

    try {
      await _adminUserRepository.postUser(user);
      final users = await _adminUserRepository.getUsers();
      emit(AdminProductLoaded(users, true));
    } on AppException catch (exception) {
      emit(AdminUserException(exception));
      await Future.delayed(const Duration(seconds: 1), () => createUser(user));
    }
  }

  Future<void> deleteUser(int id) async {
    emit(AdminUserLoading());

    try {
      await _adminUserRepository.deleteUser(id);
      final users = await _adminUserRepository.getUsers();
      emit(AdminProductLoaded(users, false));
    } on AppException catch (exception) {
      emit(AdminUserException(exception));
      await Future.delayed(const Duration(seconds: 1), () => deleteUser(id));
    }
  }

  Future<void> getUsers() async {
    emit(AdminUserLoading());

    try {
      final users = await _adminUserRepository.getUsers();
      emit(AdminProductLoaded(users, false));
    } on AppException catch (exception) {
      emit(AdminUserException(exception));
      await Future.delayed(const Duration(seconds: 1), getUsers);
    }
  }
}
