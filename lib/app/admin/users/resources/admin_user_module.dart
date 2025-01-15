import '../../../../core/core.dart';
import '../data/admin_user_repository.dart';
import '../presenter/cubit/admin_user_cubit.dart';

final class AdminUserModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<AdminUserRepository>(
      () => AdminUserRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<AdminUserCubit>(
      () => AdminUserCubit(
        AppInjector.get<AdminUserRepository>(),
      ),
    );
  }
}
