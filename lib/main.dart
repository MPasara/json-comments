import 'package:comments/common/utils/custom_provider_observer.dart';
import 'package:comments/common/utils/disabled_printer.dart';
import 'package:comments/features/comments/presentation/home_page.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: kDebugMode
        ? StreamPrinter(const PrettyDeveloperPrinter())
        : const DisabledPrinter(),
  );
  _registerErrorHandlers();
  runApp(
    ProviderScope(
      observers: [CustomProviderObserver()],
      child: const CommentsApp(),
    ),
  );
}

class CommentsApp extends StatelessWidget {
  const CommentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('hr'),
      supportedLocales: const [Locale('en'), Locale('hr')],
      localizationsDelegates: [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const HomePage(),
    );
  }
}

void _registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.red,
      title: Text(S.current.unknown_error_occurred),
    ),
    body: Center(child: Text(details.toString())),
  );
}
