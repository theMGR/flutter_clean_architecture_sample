import 'package:flearn/main_source/common_src/utils/ui_utils.dart';
import 'package:flearn/main_source/configuration/config/custom_theme.dart';
import 'package:flearn/main_source/configuration/di/init_getx_bindings.dart';
import 'package:flearn/main_source/presentation/splash_screen/splash_screen.dart';
import 'package:flearn/main_source/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'common_src/lang/local_repo_service/translation_service.dart';
import 'routes/app_pages.dart';

class MainPage extends StatefulWidget {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  const MainPage({super.key, required this.notificationAppLaunchDetails});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  DateTime? backButtonPressTime;
  final snackBarDuration = Duration(seconds: 2);
  var themeMode = ThemeMode.dark;
  var customTheme = CustomTheme();
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: handleWillPop(context),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: customTheme.toThemeDataDynamicSchemeLight(),
          darkTheme: customTheme.toThemeDataDynamicSchemeDark(),
          home: SplashScreen(),
          initialBinding: InitGetXBinding(),
          initialRoute: AppRoutes.splashScreen,
          getPages: getPagesList,
          locale: _locale,
          supportedLocales: TranslationService.supportedLocales,
          fallbackLocale: TranslationService.fallbackLocale,
          localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          translations: TranslationService(),
          builder: (context, child) {
            final data = MediaQuery.of(context);
            double textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
            return MediaQuery.withClampedTextScaling(minScaleFactor: 1, maxScaleFactor: 1.2, child: child ?? SizedBox.shrink());
          },
          onDispose: () {
            //WebSocketServer.disconnect();
          },
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      //WebSocketServer.disconnect();
    }
  }

  bool handleWillPop(BuildContext context) {
    final now = DateTime.now();
    if (backButtonPressTime == null || now.difference(backButtonPressTime!) > snackBarDuration) {
      backButtonPressTime = now;
      UIUtils.showToast(context: context, message: 'Press again to exit the app');
      return false;
    }
    return true;
  }
}
