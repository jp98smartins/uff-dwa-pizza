import '../../../../core/core.dart';
import '../../cart/data/client_cart_repository.dart';
import '../presenter/cubit/client_profile_cubit.dart';

final class ClientProfileModule implements AppModule {
  @override
  void registerDependencies() {
    // Cubits
    AppInjector.registerFactory<ClientProfileCubit>(
      () => ClientProfileCubit(
        AppInjector.get<ClientCartRepository>(),
        AppInjector.get<CoreRepository>(),
      ),
    );
  }
}
