import 'package:flutter/material.dart';

import '../app/admin/orders/presenter/admin_orders_page.dart';
import '../app/admin/orders/presenter/cubit/admin_orders_cubit.dart';
import '../app/admin/products/presenter/admin_product_page.dart';
import '../app/admin/products/presenter/cubit/admin_product_cubit.dart';
import '../app/admin/profile/presenter/admin_profile_page.dart';
import '../app/admin/profile/presenter/cubit/admin_profile_cubit.dart';
import '../app/admin/users/presenter/admin_user_page.dart';
import '../app/admin/users/presenter/cubit/admin_user_cubit.dart';
import '../app/auth/presenter/auth_page.dart';
import '../app/auth/presenter/cubit/auth_cubit.dart';
import '../app/client/cart/presenter/client_cart_page.dart';
import '../app/client/cart/presenter/cubit/client_cart_cubit.dart';
import '../app/client/orders/presenter/client_orders_page.dart';
import '../app/client/orders/presenter/cubit/client_orders_cubit.dart';
import '../app/client/payment_method/presenter/client_payment_method_page.dart';
import '../app/client/payment_method/presenter/cubit/client_payment_method_cubit.dart';
import '../app/client/products/presenter/client_products_page.dart';
import '../app/client/products/presenter/cubit/client_products_cubit.dart';
import '../app/client/profile/presenter/client_profile_page.dart';
import '../app/client/profile/presenter/cubit/client_profile_cubit.dart';
import '../app/splash/presenter/cubit/splash_cubit.dart';
import '../app/splash/presenter/splash_page.dart';
import '../core/core.dart';

sealed class AppRoutes {
  // Splash
  static const splashRoute = 'Splash';
  static const splashPath = '/';

  // Auth
  static const authRoute = 'Auth';
  static const authPath = '/auth';

  // Orders
  static const clientOrdersRoute = 'Seus Pedidos';
  static const clientOrdersPath = '/client-orders';
  static const adminOrdersRoute = 'Pedidos';
  static const adminOrdersPath = '/admin-orders';

  // Products
  static const clientProductsRoute = 'Produtos Disponíveis';
  static const clientProductsPath = '/client-products';
  static const adminProductsRoute = 'Produtos';
  static const adminProductsPath = '/admin-products';

  // Profile
  static const clientProfileRoute = 'Seu Perfil';
  static const clientProfilePath = '/client-profile';
  static const adminProfileRoute = 'Perfil';
  static const adminProfilePath = '/admin-profile';

  // Payment Methods
  static const clientPaymentMethodRoute = 'Formas de Pagamento';
  static const clientPaymentMethodPath = 'client-payment-method';

  // Cart
  static const clientCartRoute = 'Carrinho';
  static const clientCartPath = '/client-cart';

  // Users
  static const adminUsersRoute = 'Usuários';
  static const adminUsersPath = '/admin-users';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static void registerNavigationKey() {
    AppInjector.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);
  }

  // GoRouter Admin Routes
  static final adminShellRoutes = StatefulShellRoute.indexedStack(
    parentNavigatorKey: navigatorKey,
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: adminOrdersPath,
            name: adminOrdersRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<AdminOrdersCubit>(),
                  child: const AdminOrdersPage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: adminProductsPath,
            name: adminProductsRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<AdminProductCubit>(),
                  child: const AdminProductPage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: adminUsersPath,
            name: adminUsersRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<AdminUserCubit>(),
                  child: const AdminUserPage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: adminProfilePath,
            name: adminProfileRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<AdminProfileCubit>(),
                  child: const AdminProfilePage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
    ],
    builder: (context, state, navigationShell) {
      return Scaffold(
        key: state.pageKey,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pizza Delivery',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: navigationShell.goBranch,
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: [
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 0 ? const Icon(Icons.list_rounded) : const Icon(Icons.list_alt_outlined),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 1 ? const Icon(Icons.local_pizza) : const Icon(Icons.local_pizza_outlined),
              label: 'Produtos',
            ),
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 2 ? const Icon(Icons.group_rounded) : const Icon(Icons.group_outlined),
              label: 'Usuários',
            ),
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 3 ? const Icon(Icons.person) : const Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      );
    },
  );

  // GoRouter Client Routes
  static final clientShellRoutes = StatefulShellRoute.indexedStack(
    parentNavigatorKey: navigatorKey,
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: clientProductsPath,
            name: clientProductsRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<ClientProductsCubit>(),
                  child: const ClientProductsPage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: clientOrdersPath,
            name: clientOrdersRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<ClientOrdersCubit>(),
                  child: const ClientOrdersPage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: clientProfilePath,
            name: clientProfileRoute,
            pageBuilder: (context, state) {
              const transition = FadeOutTransition();
              return CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: AppInjector.get<ClientProfileCubit>(),
                  child: const ClientProfilePage(),
                ),
                transitionsBuilder: transition.transitionBuilder,
                transitionDuration: transition.transitionDuration,
                reverseTransitionDuration: transition.transitionDuration,
              );
            },
            routes: [
              GoRoute(
                path: clientPaymentMethodPath,
                name: clientPaymentMethodRoute,
                pageBuilder: (context, state) {
                  const transition = SlideLeftTransition();
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: BlocProvider.value(
                      value: AppInjector.get<ClientPaymentMethodCubit>(),
                      child: const ClientPaymentMethodPage(),
                    ),
                    transitionsBuilder: transition.transitionBuilder,
                    transitionDuration: transition.transitionDuration,
                    reverseTransitionDuration: transition.transitionDuration,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    builder: (context, state, navigationShell) {
      return Scaffold(
        key: state.pageKey,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Pizza Delivery',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(clientCartRoute),
              icon: Icon(Icons.shopping_cart),
            ),
          ],
        ),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: navigationShell.goBranch,
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: [
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 0 ? const Icon(Icons.local_pizza) : const Icon(Icons.local_pizza_outlined),
              label: 'Produtos',
            ),
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 1 ? const Icon(Icons.list_rounded) : const Icon(Icons.list_alt_outlined),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: navigationShell.currentIndex == 2 ? const Icon(Icons.person) : const Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      );
    },
  );

  // GoRouter Router
  static final routerConfig = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splashPath,
    routes: [
      GoRoute(
        path: splashPath,
        name: splashRoute,
        pageBuilder: (context, state) {
          const transition = FadeOutTransition();
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: AppInjector.get<SplashCubit>(),
              child: const SplashPage(),
            ),
            transitionsBuilder: transition.transitionBuilder,
            transitionDuration: transition.transitionDuration,
            reverseTransitionDuration: transition.transitionDuration,
          );
        },
      ),
      GoRoute(
        path: authPath,
        name: authRoute,
        pageBuilder: (context, state) {
          const transition = SlideUpTransition();
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: AppInjector.get<AuthCubit>(),
              child: const AuthPage(),
            ),
            transitionsBuilder: transition.transitionBuilder,
            transitionDuration: transition.transitionDuration,
            reverseTransitionDuration: transition.transitionDuration,
          );
        },
      ),
      GoRoute(
        path: clientCartPath,
        name: clientCartRoute,
        pageBuilder: (context, state) {
          const transition = SlideLeftTransition();
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: AppInjector.get<ClientCartCubit>(),
              child: const ClientCartPage(),
            ),
            transitionsBuilder: transition.transitionBuilder,
            transitionDuration: transition.transitionDuration,
            reverseTransitionDuration: transition.transitionDuration,
          );
        },
      ),
      adminShellRoutes,
      clientShellRoutes,
    ],
  );
}
