import '../../../../core/core.dart';
import '../../data/auth_repository.dart';
import '../../domain/models/account_model.dart';
import '../../domain/models/credentials_model.dart';

part 'auth_states.dart';

final class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final CoreRepository _coreRepository;

  AuthCubit(
    this._authRepository,
    this._coreRepository,
  ) : super(AuthInitial());

  Future<void> signIn(CredentialsModel credentials) async {
    emit(AuthLoading());

    try {
      final authEntity = await _authRepository.signIn(credentials);
      await _coreRepository.saveAuthLocally(authEntity);
      emit(AuthSignInSuccess(authEntity.user.isClient));
    } on AppException catch (exception) {
      emit(AuthException(exception));
    }
  }

  Future<void> signUp(ClientUserModel clientUser) async {
    emit(AuthLoading());

    try {
      await _authRepository.signUp(clientUser);
      emit(AuthSignUpSuccess());
    } on AppException catch (exception) {
      emit(AuthException(exception));
    }
  }
}
