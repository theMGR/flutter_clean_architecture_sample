import 'package:my_store_serverpod_backend_server/src/generated/card.dart';
import 'package:serverpod/serverpod.dart';

class CardEndpoint extends Endpoint {
  Future<Cardlist> createCard(Session session, Cardlist card) async {
    await Cardlist.db.insertRow(session, card);
    return card;
  }

  Future<bool> updateCard(Session session, Cardlist card) async {
    //return await session.db.update(card);
    await session.db.updateRow(card);
    return true;
  }
}
