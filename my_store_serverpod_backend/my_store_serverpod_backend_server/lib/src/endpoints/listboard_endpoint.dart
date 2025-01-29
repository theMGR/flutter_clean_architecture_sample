import 'package:my_store_serverpod_backend_server/src/generated/card.dart';
import 'package:my_store_serverpod_backend_server/src/generated/listboard.dart';
import 'package:serverpod/serverpod.dart';

class ListboardEndpoint extends Endpoint {
  Future<List<Listboard>> getListsByBoard(Session session, {required int boardId}) async {
    List<Listboard> lists = await Listboard.db.find(session, where: (l) => l.boardId.equals(boardId));

    for (int i = 0; i < lists.length; i++) {
      List<Cardlist> cards = await Cardlist.db.find(session, where: (c) => c.listId.equals(lists[i].id));

      lists[i].cards = cards;
    }

    return lists;
  }

  Future<Listboard> createList(Session session, Listboard lst) async {
    await Listboard.db.insertRow(session, lst);
    return lst;
  }
}
