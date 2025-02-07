import 'package:flearn/main_source/configuration/services/local_data_sync_up_process.dart';
import 'package:flearn/main_source/data/dto/latitude_longitude_dto.dart';

import 'point_in_polygon.dart';

class GeofenceService {
  final LocalDataSyncUpProcess localDataSyncUpProcess;
  GeofenceService({required this.localDataSyncUpProcess});
  GeofenceUpdateListener? geofenceUpdateListener;

  void setGeofenceUpdateListener(GeofenceUpdateListener geofenceUpdateListener) {
    this.geofenceUpdateListener = geofenceUpdateListener;
  }
  Future<void> geofence(double latitude, double longitude) async {
    if(geofenceUpdateListener != null) {
      // get local data and set lat-long and call api call
      var localData = [TempLocalData()];

      await Future.forEach(localData, (item) async {
        if (Poly().isPointInPolygon(latitude, longitude, item.listLatLong) == true) {
          await Future.forEach(item.listLatLong, (latLong) async {
            await geofenceUpdateListener!.geofenceUpdate(localData).then((value) async {
              await localDataSyncUpProcess.getNotSyncedSavedData().then((value) async {
                localDataSyncUpProcess.pushAllSavedData();
              });
            });
          });
        }
      });
    }
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
