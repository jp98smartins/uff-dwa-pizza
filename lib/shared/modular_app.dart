import '../app/auth/resources/auth_module.dart';
import '../app/products/resources/products_module.dart';
import '../app/splash/resources/splash_module.dart';
import '../core/core.dart';

final class PizzaModularApp implements ModularApp {
  const PizzaModularApp();

  @override
  List<AppModule> get modules => [
        CoreModule(),
        SplashModule(),
        AuthModule(),
        ProductsModule(),
      ];

  @override
  void registerModules() {
    for (final module in modules) {
      module.registerDependencies();
    }
  }
}
