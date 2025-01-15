import '../../../../core/core.dart';
import '../presenter/cubit/admin_profile_cubit.dart';

final class AdminProfileModule implements AppModule {
  @override
  void registerDependencies() {
    // Cubits
    AppInjector.registerFactory<AdminProfileCubit>(
      () => AdminProfileCubit(
        AppInjector.get<CoreRepository>(),
      ),
    );
  }
}
