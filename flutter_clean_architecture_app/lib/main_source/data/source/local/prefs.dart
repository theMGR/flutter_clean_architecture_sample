import 'package:flearn/main_source/configuration/config/my_shared_pref.dart';

class Prefs {
  final MySharedPref mySharedPref;

  //keys
  final String userIdKey = 'userId';
  final String latitudeKey = 'latitude';
  final String longitudeKey = 'longitude';
  final String userNameKey = 'userName';
  final String passwordKey = 'password';
  final String latLongInsertUpdateTimeKey = 'latLongInsertUpdateTime';
  final String bearerTokenKey = 'bearerToken';
  final String trackLocationKey = 'trackLocation';
  final String syncUpStartedKey = 'syncUpStarted';

  Prefs({required this.mySharedPref});

  T? get<T>(String key) => mySharedPref.get<T?>(key);

  Future<void> reload() async => await mySharedPref.reload();

  Future<bool> save({
    String? key,
    dynamic value,
    String? userId,
    double? latitude,
    double? longitude,
    String? userName,
    String? password,
    String? latLongInsertUpdateTime,
    String? bearerToken,
    bool? trackLocation,
    bool? syncUpStarted,
  }) async {
    bool response = false;
    if (key != null && value != null) {
      response = await mySharedPref.put(key, value);
    }
    if (userId != null) {
      response = await mySharedPref.put(userIdKey, userId);
    }
    if (latitude != null) {
      response = await mySharedPref.put(latitudeKey, latitude);
    }
    if (longitude != null) {
      response = await mySharedPref.put(longitudeKey, longitude);
    }
    if (userName != null) {
      response = await mySharedPref.put(userNameKey, userName);
    }
    if (password != null) {
      response = await mySharedPref.put(passwordKey, password);
    }
    if (latLongInsertUpdateTime != null) {
      response = await mySharedPref.put(latLongInsertUpdateTimeKey, latLongInsertUpdateTime);
    }
    if (bearerToken != null) {
      response = await mySharedPref.put(bearerTokenKey, bearerToken);
    }
    if (trackLocation != null) {
      response = await mySharedPref.put(trackLocationKey, trackLocation);
    }
    if (syncUpStarted != null) {
      response = await mySharedPref.put(syncUpStartedKey, syncUpStarted);
    }

    return response;
  }

  String? getUserId() => mySharedPref.get<String>(userIdKey);

  double? getLatitude() => mySharedPref.get<double>(latitudeKey);

  double? getLongitude() => mySharedPref.get<double>(longitudeKey);

  double? getUserName() => mySharedPref.get<double>(userNameKey);

  String? getPassword() => mySharedPref.get<String>(passwordKey);

  String? getLatLongInsertUpdateTime() => mySharedPref.get<String>(latLongInsertUpdateTimeKey);

  String? getBearerToken() => mySharedPref.get<String>(bearerTokenKey);

  bool? isTracking() => mySharedPref.get<bool>(trackLocationKey);

  bool? getSyncUpStatus() => mySharedPref.get<bool>(syncUpStartedKey);
}
