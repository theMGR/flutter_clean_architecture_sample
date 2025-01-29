import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ChecklistEndpoint extends Endpoint {
  Future<Checklist> createChecklist(Session session, Checklist checklist) async {
    await Checklist.db.insertRow(session, checklist);
    return checklist;
  }

  Future<bool> updateChecklist(Session session, Checklist checklist) async {
    //return await session.db.updateRow(checklist);
    await session.db.updateRow(checklist);
    return true;
  }

  Future<bool> deleteChecklistItem(Session session, Checklist checklist) async {
    //return await Checklist.db.deleteRow(session, checklist);
    await Checklist.db.deleteRow(session, checklist);
    return true;
  }

  Future<List<Checklist>> getChecklists(Session session, Cardlist crd) async {
    return await Checklist.db.find(session, where: (c) => c.cardId.equals(crd.id));
  }

  Future<bool> deleteChecklist(Session session, Cardlist crd) async {
    //await Checklist.db.delete(session, where: (c) => c.cardId.equals(crd.id));

    await Checklist.db.deleteWhere(session, where: (c) => c.cardId.equals(crd.id));
    return true;
  }
}
