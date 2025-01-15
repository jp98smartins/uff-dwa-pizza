import 'package:flutter/foundation.dart';

import '../core/core.dart';

final class AppEnvironment {
  static const _instance = AppEnvironment._();
  const AppEnvironment._();
  factory AppEnvironment() => _instance;

  static const environment = 'ENVIRONMENT';
  static const baseUrl = 'BASE_URL';
}

extension AppEnvironmentExtension on AppEnvironment {
  void logEnvironmentVars() {
    final env = getEnvironment();

    AppLogger().logInfo('''
╔════════════════╣ Running on $env
║  [ $env ] - Date and Time  | ${DateTime.now()}
║  [ $env ] - Base Url       | ${getBaseUrl()}
╚══════════════════════════════════''');
  }

  String getEnvironment() => const String.fromEnvironment(
        AppEnvironment.environment,
        defaultValue: 'PRODUCTION',
      );

  String getBaseUrl() => const String.fromEnvironment(
        AppEnvironment.baseUrl,
        defaultValue: 'https://56ae-2804-3d28-45-4b46-de8f-443a-d789-95f4.ngrok-free.app',
      );

  bool showLogs() => kDebugMode;
}
