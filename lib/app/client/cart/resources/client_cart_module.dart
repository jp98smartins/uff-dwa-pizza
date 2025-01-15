import '../../../../core/core.dart';
import '../../orders/data/client_order_repository.dart';
import '../../payment_method/data/client_payment_method_repository.dart';
import '../data/client_cart_repository.dart';
import '../presenter/cubit/client_cart_cubit.dart';

final class ClientCartModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<ClientCartRepository>(
      () => ClientCartRepositoryImpl(
        AppInjector.get<Storage>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<ClientCartCubit>(
      () => ClientCartCubit(
        AppInjector.get<ClientCartRepository>(),
        AppInjector.get<ClientOrderRepository>(),
        AppInjector.get<ClientPaymentMethodRepository>(),
      ),
    );
  }
}
