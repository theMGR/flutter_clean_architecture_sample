import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

class InternetConnectionServiceUsingGetXService extends GetxService {
  RxBool isConnected = false.obs;

  late StreamSubscription<InternetConnectionStatus> _listener;

  Future<InternetConnectionServiceUsingGetXService> init() async {
    InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker.createInstance(checkInterval: Duration(milliseconds: 300));

    _listener = internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          debugPrint('Data connection is available.------------------------------>');
          isConnected.value = true;
          break;
        case InternetConnectionStatus.disconnected:
          debugPrint('You are disconnected from the internet. ----------------------------------->');
          isConnected.value = false;
          break;
        case InternetConnectionStatus.slow:
          debugPrint('Data connection is slow.------------------------------>');
          isConnected.value = true;
          break;
      }
    });

    return this;
  }

  @override
  void onClose() {
    _listener.cancel();
    super.onClose();
  }

  void howToUse() async {
    await Get.putAsync(() async => InternetConnectionServiceUsingGetXService());

    final service = Get.find<InternetConnectionServiceUsingGetXService>();

    debugPrint('Connection status: ${service.isConnected.value}');
  }
}

class InternetConnectionServiceUsingValueNotifier {
  final ValueNotifier<bool> isConnected = ValueNotifier(false);

  late StreamSubscription<InternetConnectionStatus> _listener;

  Future<InternetConnectionServiceUsingValueNotifier> init() async {
    InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker.createInstance(checkInterval: Duration(milliseconds: 300));

    _listener = internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          debugPrint('Data connection is available.------------------------------>');
          isConnected.value = true;
          break;
        case InternetConnectionStatus.disconnected:
          debugPrint('You are disconnected from the internet. ----------------------------------->');
          isConnected.value = false;
          break;
        case InternetConnectionStatus.slow:
          debugPrint('Data connection is slow.------------------------------>');
          isConnected.value = true;
          break;
      }
    });
    return this;
  }

  void dispose() {
    _listener.cancel();

    isConnected.dispose();
  }

  void howToUse() async {
    final service = InternetConnectionServiceUsingValueNotifier();
    await service.init();

    service.isConnected.addListener(() {
      debugPrint('Connection status: ${service.isConnected.value}');
    });
  }
}

class InternetConnectionServiceUsingStreamController {
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;

  late StreamSubscription<InternetConnectionStatus> _listener;

  Future<InternetConnectionServiceUsingStreamController> init() async {
    InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker.createInstance(checkInterval: Duration(milliseconds: 300));

    _listener = internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          debugPrint('Data connection is available.------------------------------>');
          _connectionController.add(true);
          break;
        case InternetConnectionStatus.disconnected:
          debugPrint('You are disconnected from the internet. ----------------------------------->');
          _connectionController.add(false);
          break;
        case InternetConnectionStatus.slow:
          debugPrint('Data connection is slow.------------------------------>');
          _connectionController.add(true);
          break;
      }
    });
    return this;
  }

  void dispose() {
    _listener.cancel();
    _connectionController.close();
  }

  void howToUse() async {
    final service = InternetConnectionServiceUsingStreamController();
    await service.init();

    service.connectionStream.listen((isConnected) {
      debugPrint('Connection status: $isConnected');
    });
  }
}

class InternetConnectionServiceUsingBehaviorSubject {
  final BehaviorSubject<bool> _connectionSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get connectionStream => _connectionSubject.stream;

  late StreamSubscription<InternetConnectionStatus> _listener;

  Future<InternetConnectionServiceUsingBehaviorSubject> init() async {
    InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker.createInstance(checkInterval: Duration(milliseconds: 300));

    _listener = internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          debugPrint('Data connection is available.------------------------------>');
          _connectionSubject.add(true);
          break;
        case InternetConnectionStatus.disconnected:
          debugPrint('You are disconnected from the internet. ----------------------------------->');
          _connectionSubject.add(false);
          break;
        case InternetConnectionStatus.slow:
          debugPrint('Data connection is slow.------------------------------>');
          _connectionSubject.add(true);
          break;
      }
    });
    return this;
  }

  void dispose() {
    _listener.cancel();
    _connectionSubject.close();
  }

  void howToUse() async {
    final service = InternetConnectionServiceUsingBehaviorSubject();
    await service.init();

    service.connectionStream.listen((isConnected) {
      debugPrint('Connection status: $isConnected');
    });
  }
}
