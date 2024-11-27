import '../../../core/core.dart';
import '../presenter/cubit/products_cubit.dart';

final class ProductsModule implements AppModule {
  @override
  void registerDependencies() {
    // // Repositories
    // AppInjector.registerFactory<ProductsRepository>(
    //   () => ProductsRepositoryImpl(
    //     AppInjector.get<HttpClient>(),
    //   ),
    // );

    // Cubits
    AppInjector.registerFactory<ProductsCubit>(
      () => ProductsCubit(
        AppInjector.get<CoreRepository>(),
      ),
    );
  }
}
