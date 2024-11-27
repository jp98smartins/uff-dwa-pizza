import '../../../../core/core.dart';

part 'splash_states.dart';

final class SplashCubit extends Cubit<SplashState> {
  final CoreRepository _coreRepository;

  SplashCubit(
    this._coreRepository,
  ) : super(SplashLoading());

  Future<void> validateAuth() async {
    emit(SplashLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final entity = await _coreRepository.readAuthLocally();
      emit(SplashLoaded(entity));
    } on AppException catch (exception) {
      emit(SplashException(exception));
    }
  }
}
