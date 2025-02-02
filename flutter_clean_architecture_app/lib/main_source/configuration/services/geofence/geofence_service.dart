import 'package:flearn/main_source/data/dto/latitude_longitude_dto.dart';

import 'point_in_polygon.dart';

class GeofenceService {
  GeofenceService();

  Future<void> geofence(GeofenceUpdateListener geofenceUpdateListener, double latitude, double longitude) async {
    // get local data and set lat-long and call api call
    var localData = [TempLocalData()];

    await Future.forEach(localData, (item) async {
      if (Poly().isPointInPolygon(latitude, longitude, item.listLatLong) == true) {
        await Future.forEach(item.listLatLong, (latLong) async {
          await geofenceUpdateListener.geofenceUpdate(localData).then((value) async {
            await getApiCall(latitude, longitude);
          });
        });
      }
    });
  }

  Future<dynamic> getApiCall(double latitude, double longitude) async {
    int returnCode = 0;
    return returnCode;
  }
}

abstract class GeofenceUpdateListener {
  Future<dynamic> geofenceUpdate(dynamic data);
}

class TempLocalData {
  String id = '';
  String statusId = '';
  List<LatitudeLongitudeDto> listLatLong = [];
}
