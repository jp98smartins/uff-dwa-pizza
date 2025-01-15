import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/core.dart';
import 'shared/app_environment.dart';
import 'shared/app_routes.dart';
import 'shared/pizza_modular_app.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  usePathUrlStrategy();

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: const ColorScheme(
          primary: Color(0xFFE63946),
          primaryContainer: Color(0xFFFFCDD2),
          secondary: Color(0xFFF4A261),
          secondaryContainer: Color(0xFFFFF4E6),
          surface: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF000000),
          onSurface: Color(0xFF1E1E1E),
          onError: Color(0xFFFFFFFF),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lobster(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE63946),
          ),
          displayMedium: GoogleFonts.lobster(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE63946),
          ),
          displaySmall: GoogleFonts.lobster(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE63946),
          ),
          headlineLarge: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
          headlineMedium: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
          headlineSmall: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
          titleLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E1E1E),
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF1E1E1E),
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF1E1E1E),
          ),
          labelLarge: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFF4A261),
          ),
        ),
      ),
      routerConfig: routerConfig,
    );
  }
}
