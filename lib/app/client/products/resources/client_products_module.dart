import '../../../../core/core.dart';
import '../../cart/data/client_cart_repository.dart';
import '../data/client_product_repository.dart';
import '../presenter/cubit/client_products_cubit.dart';

final class ClientProductsModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<ClientProductRepository>(
      () => ClientProductRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<ClientProductsCubit>(
      () => ClientProductsCubit(
        AppInjector.get<ClientCartRepository>(),
        AppInjector.get<ClientProductRepository>(),
      ),
    );
  }
}
