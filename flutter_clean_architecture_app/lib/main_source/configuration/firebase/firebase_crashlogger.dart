import 'package:firebase_crashlytics/firebase_crashlytics.dart';

mixin FirebaseCrashLogger {
  Future<void> nonFatalError({required dynamic error, required StackTrace stackTrace}) async {
    await FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}
