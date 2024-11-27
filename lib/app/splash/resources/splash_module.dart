import '../../../core/core.dart';
import '../presenter/cubit/splash_cubit.dart';

final class SplashModule implements AppModule {
  @override
  void registerDependencies() {
    // Cubits
    AppInjector.registerFactory<SplashCubit>(
      () => SplashCubit(
        AppInjector.get<CoreRepository>(),
      ),
    );
  }
}
