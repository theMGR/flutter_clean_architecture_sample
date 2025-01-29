import 'package:my_store_serverpod_backend_server/src/generated/board.dart';
import 'package:my_store_serverpod_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BoardEndpoint extends Endpoint {
  Future<Board> createBoard(Session session, Board board) async {
    await Board.db.insertRow(session, board);
    return board;
  }

  Future<bool> updateBoard(Session session, Board board) async {
    //return await session.db.updateRow(board);
    await session.db.updateRow(board);
    return true;
  }

  Future<bool> deleteBoard(Session session, Board board) async {
    //return await Board.db.deleteRow(session, board);
    await Board.db.deleteRow(session, board);
    return true;
  }

  Future<Workspace?> getWorkspaceForBoard(Session session, Board board) async {
    Workspace? workspace = await Workspace.db.findFirstRow(
      session,
      where: (w) => w.id.equals(board.workspaceId),
    );
    return workspace;
  }

  Future<List<Board>> getAllBoards(Session session) async {
    List<Board> boards = await Board.db.find(
      session,
      where: (b) => b.id > 0,
    );
    return boards;
  }
}
