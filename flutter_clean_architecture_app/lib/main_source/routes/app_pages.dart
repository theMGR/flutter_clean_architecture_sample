import 'package:flearn/main_source/presentation/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

final getPagesList = [
  splashScreen,
];

final splashScreen = GetPage(
  name: AppRoutes.splashScreen,
  page: () => SplashScreen(),
);