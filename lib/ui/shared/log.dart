import 'package:logger/logger.dart';

void makeLog(dynamic msg, {bool simpleMode = true}) {
  //debugPrint("mytag: ${msg?.toString()}");
  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: simpleMode ? 0 : 2,
        // number of method calls to be displayed
        errorMethodCount: simpleMode ? 0 : 8,
        // number of method calls if stacktrace is provided
        lineLength: 80,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  logger.d(msg);
}
