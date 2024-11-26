import 'package:flutter/material.dart';

import '../app/auth/presenter/auth_page.dart';
import '../app/auth/presenter/cubit/auth_cubit.dart';
import '../core/core.dart';

sealed class AppRoutes {
  // Splash
  static const splashRoute = 'Splash';
  static const splashPath = '/';

  // Auth
  static const authRoute = 'Auth';
  static const authPath = '/auth';

  // Products
  static const productsRoute = 'Products';
  static const productsPath = '/products';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static void registerNavigationKey() {
    AppInjector.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);
  }

  // GoRouter Router
  static final routerConfig = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: authPath,
    routes: [
      GoRoute(
        path: authPath,
        name: authRoute,
        pageBuilder: (context, state) {
          const transition = SlideUpTransition();
          return CustomTransitionPage(
            key: state.pageKey,
            child: AuthPage(
              authCubit: AppInjector.get<AuthCubit>(),
            ),
            transitionsBuilder: transition.transitionBuilder,
            transitionDuration: transition.transitionDuration,
            reverseTransitionDuration: transition.transitionDuration,
          );
        },
      ),
      // GoRoute(
      //   path: productsPath,
      //   name: productsRoute,
      //   pageBuilder: (context, state) {
      //     const transition = SlideRightTransition();
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: ProductsPage(
      //         profileCubit: AppInjector.get<ProductsCubit>(),
      //       ),
      //       transitionsBuilder: transition.transitionBuilder,
      //       transitionDuration: transition.transitionDuration,
      //       reverseTransitionDuration: transition.transitionDuration,
      //     );
      //   },
      // ),
    ],
  );
}
