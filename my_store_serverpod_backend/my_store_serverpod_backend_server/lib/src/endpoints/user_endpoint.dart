import 'package:my_store_serverpod_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<User> createUser(Session session, User user) async {
    await User.db.insertRow(session, user);
    return user;
  }

  Future<User?> getUserById(Session session, {required int userId}) async {
    User? user = await User.db.findById(session, userId);
    return user;
  }

  Future<User?> checkUserExists(Session session, User existinguser) async {
    User? user = await User.db.findFirstRow(session, where: (u) => u.email.equals(existinguser.email) & u.password.equals(existinguser.password));

    return user;
  }

  Future<List<User>> getAllUser(Session session) async {
    return await User.db.find(session);
  }
}
