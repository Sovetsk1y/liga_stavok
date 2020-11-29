import 'package:logger/logger.dart';

class Log {
  static final _instance = Log._internal();

  final Logger _logger = Logger();

  factory Log() => _instance;

  Log._internal();

  void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
