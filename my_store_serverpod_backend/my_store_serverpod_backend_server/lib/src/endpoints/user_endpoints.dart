import 'package:my_store_serverpod_backend_server/src/generated/user.dart';
import 'package:serverpod/server.dart';

class UserEndPoints extends Endpoint{

  Future<User> addUser(Session session, User user) async {
    return await User.db.insertRow(session, user);
  }

  Future<List<User>> getAllUsers(Session session) async {
    return await User.db.find(session);
  }

}