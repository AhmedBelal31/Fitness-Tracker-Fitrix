import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void i(dynamic message) => _logger.i(message);
  static void e(dynamic message) => _logger.e(message);
  static void w(dynamic message) => _logger.w(message);
  static void d(dynamic message) => _logger.d(message);
}
