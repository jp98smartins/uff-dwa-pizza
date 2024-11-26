import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/core.dart';
import 'shared/app_environment.dart';
import 'shared/app_routes.dart';
import 'shared/modular_app.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final environment = AppEnvironment();
  AppInjector.registerSingleton<AppEnvironment>(environment);
  environment.logEnvironmentVars();

  await AppStorage().initStorage();
  await AppSecureStorage().initSecureStorage(AppStorage.instance);

  AppRoutes.registerNavigationKey();
  return runApp(
    PizzaApp(
      routerConfig: AppRoutes.routerConfig,
    ),
  );
}

final class PizzaApp extends StatelessWidget {
  final RouterConfig<Object> routerConfig;
  final ModularApp modularApp;

  PizzaApp({
    required this.routerConfig,
    this.modularApp = const PizzaModularApp(),
    super.key,
  }) {
    modularApp.registerModules();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routerConfig);
  }
}
