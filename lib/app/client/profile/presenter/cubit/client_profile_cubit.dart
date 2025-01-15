import 'package:pizza/app/client/cart/data/client_cart_repository.dart';

import '../../../../../core/core.dart';

part 'client_profile_states.dart';

final class ClientProfileCubit extends Cubit<ClientProfileState> {
  final ClientCartRepository _clientCartRepository;
  final CoreRepository _coreRepository;

  ClientProfileCubit(
    this._clientCartRepository,
    this._coreRepository,
  ) : super(ClientProfileLoading());

  Future<void> getProfile() async {
    emit(ClientProfileLoading());

    try {
      final entity = await _coreRepository.readAuthLocally();
      if (entity == null) {
        throw const AppException.business(
          AppExceptionTags.invalidCredentials,
          segment: 'Products',
          step: 'Get Products',
        );
      }

      emit(ClientProfileLoaded(entity));
    } on AppException catch (exception) {
      emit(ClientProfileException(exception));
      await Future.delayed(const Duration(seconds: 2), getProfile);
    }
  }

  Future<void> logout() async {
    emit(ClientProfileLoading());

    try {
      await _clientCartRepository.clearCart();
      await _coreRepository.clearAuth();
      emit(ClientProfileLogout());
    } on AppException catch (exception) {
      emit(ClientProfileException(exception));
      await Future.delayed(const Duration(seconds: 2), logout);
    }
  }
}
