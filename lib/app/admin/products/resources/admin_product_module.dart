import '../../../../core/core.dart';
import '../data/admin_product_repository.dart';
import '../presenter/cubit/admin_product_cubit.dart';

final class AdminProductModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<AdminProductRepository>(
      () => AdminProductRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<AdminProductCubit>(
      () => AdminProductCubit(
        AppInjector.get<AdminProductRepository>(),
      ),
    );
  }
}
