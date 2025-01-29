import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ActivityEndpoint extends Endpoint {
  Future<bool> createActivity(Session session, Activity activity) async {
    await Activity.db.insertRow(session, activity);
    return true;
  }

  Future<List<Activity>> getActivities(Session session, Cardlist crd) async {
    List<Activity> activities = await Activity.db.find(session, where: (a) => a.cardId.equals(crd.id));
    return activities;
  }
}
