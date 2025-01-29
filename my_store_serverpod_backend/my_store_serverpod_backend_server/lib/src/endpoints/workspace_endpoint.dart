import 'package:my_store_serverpod_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class WorkspaceEndpoint extends Endpoint {
  Future<Workspace> createWorkspace(Session session, Workspace workspace) async {
    await Workspace.db.insertRow(session, workspace);
    return workspace;
  }

  Future<List<Workspace>> getWorkspacesByUser(Session session, {required int userId}) async {
    List<Workspace> workspaces = await Workspace.db.find(session, where: (w) => w.userId.equals(userId));

    for (int i = 0; i < workspaces.length; i++) {
      List<Member> members = await Member.db.find(
        session,
        where: (m) => m.workspaceId.equals(workspaces[i].id),
      );

      workspaces[i].members = members;
    }
    return workspaces;
  }

  Future<Workspace?> getWorkspaceById(Session session, {required int workspaceId}) async {
    Workspace? workspace = await Workspace.db.findById(session, workspaceId);
    return workspace;
  }

  Future<List<Board>> getBoardsByWorkspace(Session session, {required int workspaceId}) async {
    List<Board> boards = await Board.db.find(session, where: (b) => b.workspaceId.equals(workspaceId));
    return boards;
  }

  Future<bool> updateWorkspace(Session session, Workspace workspace) async {
    //return await session.db.update(workspace);
    await session.db.updateRow(workspace);
    return true;
  }

  Future<bool> deleteWorkspace(Session session, Workspace workspace) async {
    //return await Workspace.db.deleteRow(session, workspace);
    await Workspace.db.deleteRow(session, workspace);
    return true;
  }
}
