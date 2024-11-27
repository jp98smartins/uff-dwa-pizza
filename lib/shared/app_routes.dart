import 'package:flutter/material.dart';

import '../app/auth/presenter/auth_page.dart';
import '../app/auth/presenter/cubit/auth_cubit.dart';
import '../app/products/presenter/cubit/products_cubit.dart';
import '../app/products/presenter/products_page.dart';
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
        path: productsPath,
        name: productsRoute,
        pageBuilder: (context, state) {
          const transition = SlideRightTransition();
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: AppInjector.get<ProductsCubit>(),
              child: const ProductsPage(),
            ),
            transitionsBuilder: transition.transitionBuilder,
            transitionDuration: transition.transitionDuration,
            reverseTransitionDuration: transition.transitionDuration,
          );
        },
      ),
    ],
  );
}
