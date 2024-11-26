import '../../../core/core.dart';

final class ProductsModule implements AppModule {
  @override
  void registerDependencies() {
    // // Repositories
    // AppInjector.registerFactory<ProductsRepository>(
    //   () => ProductsRepositoryImpl(
    //     AppInjector.get<HttpClient>(),
    //   ),
    // );

    // // Cubits
    // AppInjector.registerFactory<ProductsCubit>(
    //   () => ProductsCubit(
    //     AppInjector.get<ProductsRepository>(),
    //     AppInjector.get<CoreRepository>(),
    //   ),
    // );
  }
}
