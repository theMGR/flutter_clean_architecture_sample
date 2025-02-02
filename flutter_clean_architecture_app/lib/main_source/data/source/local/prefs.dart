import 'package:flearn/main_source/configuration/config/my_shared_pref.dart';

class Prefs {
  final MySharedPref mySharedPref;

  Prefs({required this.mySharedPref});

  Future<void> save({
    String? userId,
    double? latitude,
    double? longitude,
    String? userName,
    String? password,
    String? latLongInsertUpdateTime,
    String? bearerToken,
    bool? trackLocation
  }) async {
    if (userId != null) {
      mySharedPref.put('userId', userId);
    }
    if (latitude != null) {
      mySharedPref.put('latitude', latitude);
    }
    if (longitude != null) {
      mySharedPref.put('longitude', longitude);
    }
    if (userName != null) {
      mySharedPref.put('userName', userName);
    }
    if (password != null) {
      mySharedPref.put('password', password);
    }
    if (latLongInsertUpdateTime != null) {
      mySharedPref.put('latLongInsertUpdateTime', latLongInsertUpdateTime);
    }
    if (bearerToken != null) {
      mySharedPref.put('bearerToken', bearerToken);
    }
    if (trackLocation != null) {
      mySharedPref.put('trackLocation', trackLocation);
    }
  }

  String? getUserId() {
    return mySharedPref.get<String>('userId');
  }

  double? getLatitude() {
    return mySharedPref.get<double>('latitude');
  }

  double? getLongitude() {
    return mySharedPref.get<double>('longitude');
  }

  double? getUserName() {
    return mySharedPref.get<double>('userName');
  }

  String? getPassword() {
    return mySharedPref.get<String>('password');
  }

  String? getLatLongInsertUpdateTime() {
    return mySharedPref.get<String>('latLongInsertUpdateTime');
  }

  String? getBearerToken() {
    return mySharedPref.get<String>('bearerToken');
  }

  bool? isTracking() {
    return mySharedPref.get<bool>('trackLocation');
  }
}
