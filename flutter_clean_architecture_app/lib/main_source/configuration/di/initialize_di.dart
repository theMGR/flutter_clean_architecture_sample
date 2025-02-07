import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';
import 'package:flearn/main_source/configuration/app_config.dart';
import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/configuration/config/my_shared_pref.dart';
import 'package:flearn/main_source/configuration/services/geofence/geofence_service.dart';
import 'package:flearn/main_source/configuration/services/internet_connection_service.dart';
import 'package:flearn/main_source/configuration/services/local_data_sync_up_process.dart';
import 'package:flearn/main_source/configuration/services/location_track_transistor.dart';
import 'package:flearn/main_source/configuration/services/location_update_service.dart';
import 'package:flearn/main_source/data/repository/character_repository_impl.dart';
import 'package:flearn/main_source/data/repository/login_repository_impl.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/data/source/network/dio_api_service/dio_api_service.dart';
import 'package:flearn/main_source/domain/repository/character_repository.dart';
import 'package:flearn/main_source/domain/repository/login_repository.dart';
import 'package:flearn/main_source/domain/usecase/login_usecase.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDi() async {
  AppConfiguration appConfig = appConfiguration;
  MySharedPref mySharedPref = MySharedPref();
  Prefs prefs = Prefs(mySharedPref: mySharedPref);
  DioApiService dioApiService = DioApiService(dio: getDio(baseUrl: AppStrings.get().baseUrl()), prefs: prefs);
  LocalDataSyncUpProcess localDataSyncUpProcess = LocalDataSyncUpProcess();
  GeofenceService geofenceService = GeofenceService(localDataSyncUpProcess: localDataSyncUpProcess);

  InternetConnectionServiceUsingGetXService internetConnectionServiceUsingGetXService = await InternetConnectionServiceUsingGetXService().init();
  InternetConnectionServiceUsingValueNotifier internetConnectionServiceUsingValueNotifier = await InternetConnectionServiceUsingValueNotifier().init();
  InternetConnectionServiceUsingStreamController internetConnectionServiceUsingStreamController = await InternetConnectionServiceUsingStreamController().init();
  InternetConnectionServiceUsingBehaviorSubject internetConnectionServiceUsingBehaviorSubject = await InternetConnectionServiceUsingBehaviorSubject().init();

  LoginRepository loginRepository = LoginRepositoryImpl(dioApiService: dioApiService, prefs: prefs);
  CharacterRepository characterRepository = CharacterRepositoryImpl(dioApiService: dioApiService, prefs: prefs);

  LocationUpdateUseCase locationUpdateUseCase = LocationUpdateUseCase(repository: loginRepository);
  UserStatusUpdateUseCase userStatusUpdateUseCase = UserStatusUpdateUseCase(repository: loginRepository);

  LocationTrackByTransistor locationTrackByTransistor = await LocationTrackByTransistor(
    geofenceService: geofenceService,
    prefs: prefs,
    userStatusUpdateUseCase: userStatusUpdateUseCase,
    localDataSyncUpProcess: localDataSyncUpProcess,
  ).backgroundFetchConfig();
  LocationUpdateService locationUpdateService = LocationUpdateService(
    prefs: prefs,
    locationTrackByTransistor: locationTrackByTransistor,
    locationUpdateUseCase: locationUpdateUseCase,
  );

  // GET-IT
  getIt.registerLazySingleton<AppConfiguration>(() => appConfig);
  getIt.registerLazySingleton<MySharedPref>(() => mySharedPref);
  getIt.registerLazySingleton<Prefs>(() => prefs);
  getIt.registerLazySingleton<DioApiService>(() => dioApiService);
  getIt.registerLazySingleton<GeofenceService>(() => geofenceService);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingGetXService>(() async => internetConnectionServiceUsingGetXService);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingValueNotifier>(() async => internetConnectionServiceUsingValueNotifier);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingStreamController>(() async => internetConnectionServiceUsingStreamController);
  getIt.registerLazySingletonAsync<InternetConnectionServiceUsingBehaviorSubject>(() async => internetConnectionServiceUsingBehaviorSubject);
  getIt.registerLazySingletonAsync<LocationTrackByTransistor>(() async => locationTrackByTransistor);
  getIt.registerFactory<LoginRepository>(() => loginRepository);
  getIt.registerFactory<CharacterRepository>(() => characterRepository);
  getIt.registerLazySingleton<LocationUpdateUseCase>(() => locationUpdateUseCase);
  getIt.registerLazySingleton<LocationUpdateService>(() => locationUpdateService);
  getIt.registerLazySingleton<UserStatusUpdateUseCase>(() => userStatusUpdateUseCase);
  getIt.registerLazySingleton<LocalDataSyncUpProcess>(() => localDataSyncUpProcess);

  // GET-X
  Get.lazyPut<AppConfiguration>(() => appConfig);
  Get.lazyPut<MySharedPref>(() => mySharedPref);
  Get.lazyPut<Prefs>(() => prefs);
  Get.lazyPut<DioApiService>(() => dioApiService);
  Get.lazyPut<GeofenceService>(() => geofenceService);
  Get.putAsync<InternetConnectionServiceUsingGetXService>(() async => internetConnectionServiceUsingGetXService);
  Get.putAsync<InternetConnectionServiceUsingValueNotifier>(() async => internetConnectionServiceUsingValueNotifier);
  Get.putAsync<InternetConnectionServiceUsingStreamController>(() async => internetConnectionServiceUsingStreamController);
  Get.putAsync<InternetConnectionServiceUsingBehaviorSubject>(() async => internetConnectionServiceUsingBehaviorSubject);
  Get.putAsync<LocationTrackByTransistor>(() async => locationTrackByTransistor);
  Get.lazyPut<LoginRepository>(() => loginRepository);
  Get.lazyPut<CharacterRepository>(() => characterRepository);
  Get.lazyPut<LocationUpdateUseCase>(() => locationUpdateUseCase);
  Get.lazyPut<LocationUpdateService>(() => locationUpdateService);
  Get.lazyPut<UserStatusUpdateUseCase>(() => userStatusUpdateUseCase);
  Get.lazyPut<LocalDataSyncUpProcess>(() => localDataSyncUpProcess);
}

Future<void> resetDi() async {
  GetIt.I.reset();
  Get.deleteAll();
  await initializeDi();
}
