/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:my_store_serverpod_backend_client/src/protocol/activity.dart'
    as _i3;
import 'package:my_store_serverpod_backend_client/src/protocol/card.dart'
    as _i4;
import 'package:my_store_serverpod_backend_client/src/protocol/attachment.dart'
    as _i5;
import 'package:my_store_serverpod_backend_client/src/protocol/board.dart'
    as _i6;
import 'package:my_store_serverpod_backend_client/src/protocol/workspace.dart'
    as _i7;
import 'package:my_store_serverpod_backend_client/src/protocol/checklist.dart'
    as _i8;
import 'package:my_store_serverpod_backend_client/src/protocol/comment.dart'
    as _i9;
import 'package:my_store_serverpod_backend_client/src/protocol/listboard.dart'
    as _i10;
import 'package:my_store_serverpod_backend_client/src/protocol/member.dart'
    as _i11;
import 'package:my_store_serverpod_backend_client/src/protocol/user.dart'
    as _i12;
import 'package:my_store_serverpod_backend_client/src/protocol/mobile_auth_model.dart'
    as _i13;
import 'protocol.dart' as _i14;

/// {@category Endpoint}
class EndpointActivity extends _i1.EndpointRef {
  EndpointActivity(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'activity';

  _i2.Future<bool> createActivity(_i3.Activity activity) =>
      caller.callServerEndpoint<bool>(
        'activity',
        'createActivity',
        {'activity': activity},
      );

  _i2.Future<List<_i3.Activity>> getActivities(_i4.Cardlist crd) =>
      caller.callServerEndpoint<List<_i3.Activity>>(
        'activity',
        'getActivities',
        {'crd': crd},
      );
}

/// {@category Endpoint}
class EndpointAttachment extends _i1.EndpointRef {
  EndpointAttachment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'attachment';

  _i2.Future<_i5.Attachment> addAttachment(_i5.Attachment attachment) =>
      caller.callServerEndpoint<_i5.Attachment>(
        'attachment',
        'addAttachment',
        {'attachment': attachment},
      );

  _i2.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'attachment',
        'getUploadDescription',
        {'path': path},
      );

  _i2.Future<bool> verifyUpload(String path) => caller.callServerEndpoint<bool>(
        'attachment',
        'verifyUpload',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointBoard extends _i1.EndpointRef {
  EndpointBoard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'board';

  _i2.Future<_i6.Board> createBoard(_i6.Board board) =>
      caller.callServerEndpoint<_i6.Board>(
        'board',
        'createBoard',
        {'board': board},
      );

  _i2.Future<bool> updateBoard(_i6.Board board) =>
      caller.callServerEndpoint<bool>(
        'board',
        'updateBoard',
        {'board': board},
      );

  _i2.Future<bool> deleteBoard(_i6.Board board) =>
      caller.callServerEndpoint<bool>(
        'board',
        'deleteBoard',
        {'board': board},
      );

  _i2.Future<_i7.Workspace?> getWorkspaceForBoard(_i6.Board board) =>
      caller.callServerEndpoint<_i7.Workspace?>(
        'board',
        'getWorkspaceForBoard',
        {'board': board},
      );

  _i2.Future<List<_i6.Board>> getAllBoards() =>
      caller.callServerEndpoint<List<_i6.Board>>(
        'board',
        'getAllBoards',
        {},
      );
}

/// {@category Endpoint}
class EndpointCard extends _i1.EndpointRef {
  EndpointCard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'card';

  _i2.Future<_i4.Cardlist> createCard(_i4.Cardlist card) =>
      caller.callServerEndpoint<_i4.Cardlist>(
        'card',
        'createCard',
        {'card': card},
      );

  _i2.Future<bool> updateCard(_i4.Cardlist card) =>
      caller.callServerEndpoint<bool>(
        'card',
        'updateCard',
        {'card': card},
      );
}

/// {@category Endpoint}
class EndpointChecklist extends _i1.EndpointRef {
  EndpointChecklist(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'checklist';

  _i2.Future<_i8.Checklist> createChecklist(_i8.Checklist checklist) =>
      caller.callServerEndpoint<_i8.Checklist>(
        'checklist',
        'createChecklist',
        {'checklist': checklist},
      );

  _i2.Future<bool> updateChecklist(_i8.Checklist checklist) =>
      caller.callServerEndpoint<bool>(
        'checklist',
        'updateChecklist',
        {'checklist': checklist},
      );

  _i2.Future<bool> deleteChecklistItem(_i8.Checklist checklist) =>
      caller.callServerEndpoint<bool>(
        'checklist',
        'deleteChecklistItem',
        {'checklist': checklist},
      );

  _i2.Future<List<_i8.Checklist>> getChecklists(_i4.Cardlist crd) =>
      caller.callServerEndpoint<List<_i8.Checklist>>(
        'checklist',
        'getChecklists',
        {'crd': crd},
      );

  _i2.Future<bool> deleteChecklist(_i4.Cardlist crd) =>
      caller.callServerEndpoint<bool>(
        'checklist',
        'deleteChecklist',
        {'crd': crd},
      );
}

/// {@category Endpoint}
class EndpointComment extends _i1.EndpointRef {
  EndpointComment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'comment';

  _i2.Future<_i9.Comment> createComment(_i9.Comment comment) =>
      caller.callServerEndpoint<_i9.Comment>(
        'comment',
        'createComment',
        {'comment': comment},
      );

  _i2.Future<_i9.Comment> deleteComment(_i9.Comment comment) =>
      caller.callServerEndpoint<_i9.Comment>(
        'comment',
        'deleteComment',
        {'comment': comment},
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointListboard extends _i1.EndpointRef {
  EndpointListboard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listboard';

  _i2.Future<List<_i10.Listboard>> getListsByBoard({required int boardId}) =>
      caller.callServerEndpoint<List<_i10.Listboard>>(
        'listboard',
        'getListsByBoard',
        {'boardId': boardId},
      );

  _i2.Future<_i10.Listboard> createList(_i10.Listboard lst) =>
      caller.callServerEndpoint<_i10.Listboard>(
        'listboard',
        'createList',
        {'lst': lst},
      );
}

/// {@category Endpoint}
class EndpointMember extends _i1.EndpointRef {
  EndpointMember(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'member';

  _i2.Future<_i11.Member> addMember(_i11.Member member) =>
      caller.callServerEndpoint<_i11.Member>(
        'member',
        'addMember',
        {'member': member},
      );

  _i2.Future<List<_i11.Member>> getMembersByWorkspace(
          {required int workspaceId}) =>
      caller.callServerEndpoint<List<_i11.Member>>(
        'member',
        'getMembersByWorkspace',
        {'workspaceId': workspaceId},
      );

  _i2.Future<List<_i12.User>> getInformationOfMembers(
          List<_i11.Member> members) =>
      caller.callServerEndpoint<List<_i12.User>>(
        'member',
        'getInformationOfMembers',
        {'members': members},
      );

  _i2.Future<_i7.Workspace> deleteMember(
    _i11.Member member,
    _i7.Workspace workspace,
  ) =>
      caller.callServerEndpoint<_i7.Workspace>(
        'member',
        'deleteMember',
        {
          'member': member,
          'workspace': workspace,
        },
      );
}

/// {@category Endpoint}
class EndpointMobileAuthEndPoint extends _i1.EndpointRef {
  EndpointMobileAuthEndPoint(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mobileAuthEndPoint';

  _i2.Future<_i13.MobileAuthModel?> addMobileAuth(_i13.MobileAuthModel input) =>
      caller.callServerEndpoint<_i13.MobileAuthModel?>(
        'mobileAuthEndPoint',
        'addMobileAuth',
        {'input': input},
      );

  _i2.Future<_i13.MobileAuthModel?> getMobileAuthByPhone(String phone) =>
      caller.callServerEndpoint<_i13.MobileAuthModel?>(
        'mobileAuthEndPoint',
        'getMobileAuthByPhone',
        {'phone': phone},
      );

  _i2.Future<bool> updateToken(
    String phone,
    String token,
  ) =>
      caller.callServerEndpoint<bool>(
        'mobileAuthEndPoint',
        'updateToken',
        {
          'phone': phone,
          'token': token,
        },
      );

  _i2.Future<bool> verifyOTP(
    String phone,
    String otp,
  ) =>
      caller.callServerEndpoint<bool>(
        'mobileAuthEndPoint',
        'verifyOTP',
        {
          'phone': phone,
          'otp': otp,
        },
      );

  _i2.Future<String?> generateOTP(String phone) =>
      caller.callServerEndpoint<String?>(
        'mobileAuthEndPoint',
        'generateOTP',
        {'phone': phone},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i12.User> createUser(_i12.User user) =>
      caller.callServerEndpoint<_i12.User>(
        'user',
        'createUser',
        {'user': user},
      );

  _i2.Future<_i12.User?> getUserById({required int userId}) =>
      caller.callServerEndpoint<_i12.User?>(
        'user',
        'getUserById',
        {'userId': userId},
      );

  _i2.Future<_i12.User?> checkUserExists(_i12.User existinguser) =>
      caller.callServerEndpoint<_i12.User?>(
        'user',
        'checkUserExists',
        {'existinguser': existinguser},
      );
}

/// {@category Endpoint}
class EndpointWorkspace extends _i1.EndpointRef {
  EndpointWorkspace(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workspace';

  _i2.Future<_i7.Workspace> createWorkspace(_i7.Workspace workspace) =>
      caller.callServerEndpoint<_i7.Workspace>(
        'workspace',
        'createWorkspace',
        {'workspace': workspace},
      );

  _i2.Future<List<_i7.Workspace>> getWorkspacesByUser({required int userId}) =>
      caller.callServerEndpoint<List<_i7.Workspace>>(
        'workspace',
        'getWorkspacesByUser',
        {'userId': userId},
      );

  _i2.Future<_i7.Workspace?> getWorkspaceById({required int workspaceId}) =>
      caller.callServerEndpoint<_i7.Workspace?>(
        'workspace',
        'getWorkspaceById',
        {'workspaceId': workspaceId},
      );

  _i2.Future<List<_i6.Board>> getBoardsByWorkspace(
          {required int workspaceId}) =>
      caller.callServerEndpoint<List<_i6.Board>>(
        'workspace',
        'getBoardsByWorkspace',
        {'workspaceId': workspaceId},
      );

  _i2.Future<bool> updateWorkspace(_i7.Workspace workspace) =>
      caller.callServerEndpoint<bool>(
        'workspace',
        'updateWorkspace',
        {'workspace': workspace},
      );

  _i2.Future<bool> deleteWorkspace(_i7.Workspace workspace) =>
      caller.callServerEndpoint<bool>(
        'workspace',
        'deleteWorkspace',
        {'workspace': workspace},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i14.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    activity = EndpointActivity(this);
    attachment = EndpointAttachment(this);
    board = EndpointBoard(this);
    card = EndpointCard(this);
    checklist = EndpointChecklist(this);
    comment = EndpointComment(this);
    example = EndpointExample(this);
    listboard = EndpointListboard(this);
    member = EndpointMember(this);
    mobileAuthEndPoint = EndpointMobileAuthEndPoint(this);
    user = EndpointUser(this);
    workspace = EndpointWorkspace(this);
  }

  late final EndpointActivity activity;

  late final EndpointAttachment attachment;

  late final EndpointBoard board;

  late final EndpointCard card;

  late final EndpointChecklist checklist;

  late final EndpointComment comment;

  late final EndpointExample example;

  late final EndpointListboard listboard;

  late final EndpointMember member;

  late final EndpointMobileAuthEndPoint mobileAuthEndPoint;

  late final EndpointUser user;

  late final EndpointWorkspace workspace;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'activity': activity,
        'attachment': attachment,
        'board': board,
        'card': card,
        'checklist': checklist,
        'comment': comment,
        'example': example,
        'listboard': listboard,
        'member': member,
        'mobileAuthEndPoint': mobileAuthEndPoint,
        'user': user,
        'workspace': workspace,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
