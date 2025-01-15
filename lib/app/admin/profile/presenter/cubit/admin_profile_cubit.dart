import '../../../../../core/core.dart';

part 'admin_profile_states.dart';

final class AdminProfileCubit extends Cubit<AdminProfileState> {
  final CoreRepository _coreRepository;

  AdminProfileCubit(
    this._coreRepository,
  ) : super(AdminProfileLoading());

  Future<void> getProfile() async {
    emit(AdminProfileLoading());

    try {
      final entity = await _coreRepository.readAuthLocally();
      if (entity == null) {
        throw const AppException.business(
          AppExceptionTags.invalidCredentials,
          segment: 'Auth',
          step: 'Get Profile',
        );
      }

      emit(AdminProfileLoaded(entity));
    } on AppException catch (exception) {
      emit(AdminProfileException(exception));
      await Future.delayed(const Duration(seconds: 2), getProfile);
    }
  }

  Future<void> logout() async {
    emit(AdminProfileLoading());

    try {
      await _coreRepository.clearAuth();
      emit(ClientProfileLogout());
    } on AppException catch (exception) {
      emit(AdminProfileException(exception));
      await Future.delayed(const Duration(seconds: 2), logout);
    }
  }
}
