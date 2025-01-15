import '../app/admin/orders/resources/admin_orders_module.dart';
import '../app/admin/products/resources/admin_product_module.dart';
import '../app/admin/profile/resources/admin_profile_module.dart';
import '../app/admin/users/resources/admin_user_module.dart';
import '../app/auth/resources/auth_module.dart';
import '../app/client/cart/resources/client_cart_module.dart';
import '../app/client/orders/resources/client_orders_module.dart';
import '../app/client/payment_method/resources/client_payment_method_module.dart';
import '../app/client/products/resources/client_products_module.dart';
import '../app/client/profile/resources/client_profile_module.dart';
import '../app/splash/resources/splash_module.dart';
import '../core/core.dart';
import 'pizza_app_module.dart';

final class PizzaModularApp implements ModularApp {
  const PizzaModularApp();

  @override
  List<AppModule> get modules => [
        CoreModule(),
        PizzaAppModule(),
        SplashModule(),
        AuthModule(),
        ClientOrdersModule(),
        ClientProductsModule(),
        ClientProfileModule(),
        ClientPaymentMethodModule(),
        ClientCartModule(),
        AdminOrdersModule(),
        AdminProductModule(),
        AdminProfileModule(),
        AdminUserModule(),
      ];

  @override
  void registerModules() {
    for (final module in modules) {
      module.registerDependencies();
    }
  }
}
