import 'dart:async';

import '../enums/logger_color.dart';

/// The available options to log messages.
abstract interface class LoggerOptions {
  /// The method that should be used to log error messages.
  ///
  /// By default the color of this log will be [LoggerColor.red].
  void logError(
    String message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  });

  /// The method that should be used to log info messages.
  ///
  /// By default the color of this log will be [LoggerColor.cyan].
  void logInfo(
    String message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  });

  /// The method that should be used to log success messages.
  ///
  /// By default the color of this log will be [LoggerColor.green].
  void logSuccess(
    String message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  });

  /// The method that should be used to log warning messages.
  ///
  /// By default the color of this log will be [LoggerColor.yellow].
  void logWarning(
    String message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  });
}
