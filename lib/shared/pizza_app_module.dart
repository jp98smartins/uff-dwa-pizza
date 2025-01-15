import '../core/core.dart';
import 'app_environment.dart';

final class PizzaAppModule implements AppModule {
  @override
  void registerDependencies() {
    final environment = AppInjector.get<AppEnvironment>();

    // Http Client
    AppInjector.registerLazySingleton<HttpClient>(
      () => AppHttpClient(
        environment.getBaseUrl(),
        authorization: AuthorizationOptions(
          coreRepository: AppInjector.get<CoreRepository>(),
        ),
        showLogs: environment.showLogs(),
      ),
    );
  }
}
