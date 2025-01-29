import 'package:my_store_serverpod_backend_server/src/generated/attachment.dart';
import 'package:serverpod/serverpod.dart';

class AttachmentEndpoint extends Endpoint {
  Future<Attachment> addAttachment(Session session, Attachment attachment) async {
    await Attachment.db.insertRow(session, attachment);
    return attachment;
  }

  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }
}
