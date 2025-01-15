import '../../../../core/core.dart';
import '../data/admin_order_repository.dart';
import '../presenter/cubit/admin_orders_cubit.dart';

final class AdminOrdersModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<AdminOrderRepository>(
      () => AdminOrderRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<AdminOrdersCubit>(
      () => AdminOrdersCubit(
        AppInjector.get<AdminOrderRepository>(),
      ),
    );
  }
}
