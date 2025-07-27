import 'package:loggy/loggy.dart';

class DisabledPrinter extends LoggyPrinter {
  const DisabledPrinter() : super();

  @override
  void onLog(LogRecord record) {}
}
