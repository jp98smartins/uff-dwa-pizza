import '../../../../core/core.dart';
import '../data/client_payment_method_repository.dart';
import '../presenter/cubit/client_payment_method_cubit.dart';

final class ClientPaymentMethodModule implements AppModule {
  @override
  void registerDependencies() {
    // Repositories
    AppInjector.registerFactory<ClientPaymentMethodRepository>(
      () => ClientPaymentMethodRepositoryImpl(
        AppInjector.get<HttpClient>(),
      ),
    );

    // Cubits
    AppInjector.registerFactory<ClientPaymentMethodCubit>(
      () => ClientPaymentMethodCubit(
        AppInjector.get<ClientPaymentMethodRepository>(),
      ),
    );
  }
}
