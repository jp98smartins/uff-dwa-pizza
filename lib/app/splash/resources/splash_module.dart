import '../../../core/core.dart';

final class SplashModule implements AppModule {
  @override
  void registerDependencies() {
    // // Repositories
    // AppInjector.registerFactory<SplashRepository>(
    //   () => SplashRepositoryImpl(
    //     AppInjector.get<HttpClient>(),
    //   ),
    // );

    // // Cubits
    // AppInjector.registerFactory<SplashCubit>(
    //   () => SplashCubit(
    //     AppInjector.get<SplashRepository>(),
    //     AppInjector.get<CoreRepository>(),
    //   ),
    // );
  }
}
