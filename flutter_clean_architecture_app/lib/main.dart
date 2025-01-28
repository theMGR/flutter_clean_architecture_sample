import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flearn/layers/presentation/app_root.dart';
import 'package:flearn/layers/presentation/using_get_it/injector.dart';
//import 'package:my_pod_client/my_pod_client.dart';
import 'package:my_store_serverpod_backend_client/my_store_serverpod_backend_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StateManagementOptions {
  bloc,
  cubit,
  provider,
  riverpod,
  getIt,
  mobX,
  bluetoothEx,
  serverPodEx,
}

late SharedPreferences sharedPref;

//var client = Client('http://$localhost:7070/')..connectivityMonitor = FlutterConnectivityMonitor();
var client = Client('http://$localhost:8080/')..connectivityMonitor = FlutterConnectivityMonitor();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await initializeGetIt();
  Animate.restartOnHotReload = true;

  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(const ProviderScope(child: AppRoot()));
}
