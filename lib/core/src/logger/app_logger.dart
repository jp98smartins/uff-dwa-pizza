import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'enums/logger_color.dart';
import 'interfaces/logger_options.dart';

export 'enums/logger_color.dart';

/// Class that handles the logging.
final class AppLogger implements LoggerOptions {
  @override
  void logError(
    Object? message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  }) {
    return log(
      message,
      color: LoggerColor.red,
      level: level,
      sequenceNumber: sequenceNumber,
      time: time,
      zone: zone,
    );
  }

  @override
  void logInfo(
    Object? message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  }) {
    return log(
      message,
      color: LoggerColor.cyan,
      level: level,
      sequenceNumber: sequenceNumber,
      time: time,
      zone: zone,
    );
  }

  @override
  void logSuccess(
    Object? message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  }) {
    return log(
      message,
      color: LoggerColor.green,
      level: level,
      sequenceNumber: sequenceNumber,
      time: time,
      zone: zone,
    );
  }

  @override
  void logWarning(
    Object? message, {
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  }) {
    return log(
      message,
      color: LoggerColor.yellow,
      level: level,
      sequenceNumber: sequenceNumber,
      time: time,
      zone: zone,
    );
  }

  /// The default method to log the messages on terminal.
  static void log(
    Object? message, {
    LoggerColor color = LoggerColor.black,
    int level = 0,
    int? sequenceNumber,
    DateTime? time,
    Zone? zone,
  }) {
    if (kReleaseMode) return;
    final levelString = level > 0 ? '\t' * level : '';
    final sequenceColored = sequenceNumber != null ? '[ $sequenceNumber ] ' : '';
    final timeColored = time != null ? '[ ${time.toIso8601String()} ] ' : '';

    final settingsString = '$levelString$sequenceColored$timeColored';

    developer.log('\x1B[${color.asANSI}m$settingsString${message.toString()}\x1B[0m');
  }
}
