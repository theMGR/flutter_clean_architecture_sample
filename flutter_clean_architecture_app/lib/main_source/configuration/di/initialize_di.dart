import 'package:flearn/main_source/configuration/app_config.dart';
import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/configuration/config/my_shared_pref.dart';
import 'package:flearn/main_source/configuration/services/geofence/geofence_service.dart';
import 'package:flearn/main_source/configuration/services/internet_connection_service.dart';
import 'package:flearn/main_source/configuration/services/location_track_transistor.dart';
import 'package:flearn/main_source/configuration/services/location_update_service.dart';
import 'package:flearn/main_source/data/repository/login_repository_impl.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/domain/repository/login_repository.dart';
import 'package:flearn/main_source/domain/usecase/login_usecase.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDi() async {
  AppConfiguration appConfig = appConfiguration;
  MySharedPref mySharedPref = MySharedPref();
  Prefs prefs = Prefs(mySharedPref: mySharedPref);
  GeofenceService geofenceService = GeofenceService();
  InternetConnectionServiceUsingGetXService internetConnectionServiceUsingGetXService = await InternetConnectionServiceUsingGetXService().init();
  InternetConnectionServiceUsingValueNotifier internetConnectionServiceUsingValueNotifier = await InternetConnectionServiceUsingValueNotifier().init();
  InternetConnectionServiceUsingStreamController internetConnectionServiceUsingStreamController = await InternetConnectionServiceUsingStreamController().init();
  InternetConnectionServiceUsingBehaviorSubject internetConnectionServiceUsingBehaviorSubject = await InternetConnectionServiceUsingBehaviorSubject().init();

  LocationTrackByTransistor locationTrackByTransistor = await LocationTrackByTransistor(geofenceService, prefs).backgroundFetchConfig();
  LoginRepository loginRepository = LoginRepositoryImpl();

  LocationUpdateUseCase locationUpdateUseCase = LocationUpdateUseCase(repository: loginRepository);

  LocationUpdateService locationUpdateService = LocationUpdateService(prefs: prefs, locationTrackByTransistor: locationTrackByTransistor, locationUpdateUseCase: locationUpdateUseCase);

  // GET-IT
  getIt.registerLazySingleton<AppConfiguration>(() => appConfig);
  getIt.registerLazySingleton<MySharedPref>(() => mySharedPref);
  getIt.registerLazySingleton<Prefs>(() => prefs);
  getIt.registerLazySingleton<GeofenceService>(() => geofenceService);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingGetXService>(() async => internetConnectionServiceUsingGetXService);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingValueNotifier>(() async => internetConnectionServiceUsingValueNotifier);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingStreamController>(() async => internetConnectionServiceUsingStreamController);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingBehaviorSubject>(() async => internetConnectionServiceUsingBehaviorSubject);
  getIt.registerLazySingletonAsync<LocationTrackByTransistor>(() async => locationTrackByTransistor);
  getIt.registerFactory<LoginRepository>(() => loginRepository);
  getIt.registerLazySingleton<LocationUpdateUseCase>(() => locationUpdateUseCase);
  getIt.registerLazySingleton<LocationUpdateService>(() => locationUpdateService);

  // GET-X
  Get.lazyPut<AppConfiguration>(() => appConfig);
  Get.lazyPut<MySharedPref>(() => mySharedPref);
  Get.lazyPut<Prefs>(() => prefs);
  Get.lazyPut<GeofenceService>(() => geofenceService);
  Get.putAsync<InternetConnectionServiceUsingGetXService>(() async => internetConnectionServiceUsingGetXService);
  Get.putAsync<InternetConnectionServiceUsingValueNotifier>(() async => internetConnectionServiceUsingValueNotifier);
  Get.putAsync<InternetConnectionServiceUsingStreamController>(() async => internetConnectionServiceUsingStreamController);
  Get.putAsync<InternetConnectionServiceUsingBehaviorSubject>(() async => internetConnectionServiceUsingBehaviorSubject);
  Get.putAsync<LocationTrackByTransistor>(() async => locationTrackByTransistor);
  Get.lazyPut<LoginRepository>(() => loginRepository);
  Get.lazyPut<LocationUpdateUseCase>(() => locationUpdateUseCase);
  Get.lazyPut<LocationUpdateService>(() => locationUpdateService);

}
