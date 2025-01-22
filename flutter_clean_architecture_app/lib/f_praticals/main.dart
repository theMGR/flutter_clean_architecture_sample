import 'dart:io';

import 'package:flearn/f_praticals/pages/home_page.dart';
import 'package:flearn/f_praticals/source/config/themes/app_theme.dart';
import 'package:flearn/f_praticals/source/config/utils/context_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(400, 800));
    WindowManager.instance.setMinimumSize(const Size(400, 800));
    WindowManager.instance.setMaximumSize(const Size(400, 800));
  }
  runApp(const MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> pushPage(Widget page) async {
    return await Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => page));
  }

  static void pop(dynamic result) {
    Navigator.pop(navigatorKey.currentContext!, result);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'F Practicals',
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        home: const HomePage(),
      ),
    );
  }
}
