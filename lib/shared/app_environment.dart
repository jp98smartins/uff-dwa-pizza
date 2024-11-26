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

  String getEnvironment() => const String.fromEnvironment(AppEnvironment.environment);

  String getBaseUrl() => const String.fromEnvironment(AppEnvironment.baseUrl);

  bool showLogs() => kDebugMode;
}
