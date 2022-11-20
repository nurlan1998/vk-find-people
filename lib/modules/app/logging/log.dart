import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'logging.dart';

class Log {
  Log._();

  static late Logger _loggerInstance;

  static void initialize() {
    Logger.level = kDebugMode ? Level.verbose : Level.nothing;
    _loggerInstance = Logging.instance();
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance.wtf(message, error, stackTrace);
  }
}