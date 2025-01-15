import 'data/data.dart';
import 'injector/app_injector.dart';
import 'module/app_module.dart';
import 'storages/app_secure_storage.dart';
import 'storages/app_storage.dart';
import 'uuid/app_uuid.dart';

final class CoreModule implements AppModule {
  @override
  void registerDependencies() {
    // Externals
    AppInjector.registerSingleton<AppUuid>(
      AppUuidImpl(),
    );
    AppInjector.registerLazySingleton<Storage>(
      () => AppStorage.instance,
    );
    AppInjector.registerLazySingleton<SecureStorage>(
      () => AppSecureStorage.instance,
    );

    // Repositories
    AppInjector.registerLazySingleton<CoreRepository>(
      () => CoreRepositoryImpl(
        AppInjector.get<SecureStorage>(),
      ),
    );
  }
}
