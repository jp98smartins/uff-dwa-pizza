import '../../../core/core.dart';

final class AuthModule implements AppModule {
  @override
  void registerDependencies() {
    // // Repositories
    // AppInjector.registerFactory<AuthRepository>(
    //   () => AuthRepositoryImpl(
    //     AppInjector.get<HttpClient>(),
    //   ),
    // );

    // // Cubits
    // AppInjector.registerFactory<AuthCubit>(
    //   () => AuthCubit(
    //     AppInjector.get<AuthRepository>(),
    //     AppInjector.get<CoreRepository>(),
    //   ),
    // );
  }
}
