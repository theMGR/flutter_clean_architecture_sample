import 'package:my_store_serverpod_backend_server/src/generated/comment.dart';
import 'package:serverpod/serverpod.dart';

class CommentEndpoint extends Endpoint {
  Future<Comment> createComment(Session session, Comment comment) async {
    await Comment.db.insertRow(session, comment);
    return comment;
  }

  Future<Comment> deleteComment(Session session, Comment comment) async {
    return await Comment.db.deleteRow(session, comment);
  }
}
