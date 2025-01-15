import '../../../../core/core.dart';
import '../data/client_order_repository.dart';
import '../presenter/cubit/client_orders_cubit.dart';

final class ClientOrdersModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<ClientOrderRepository>(
      () => ClientOrderRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<ClientOrdersCubit>(
      () => ClientOrdersCubit(
        AppInjector.get<ClientOrderRepository>(),
      ),
    );
  }
}
