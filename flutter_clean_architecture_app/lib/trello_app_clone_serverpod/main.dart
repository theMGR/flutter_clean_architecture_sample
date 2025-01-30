import 'package:provider/provider.dart';
import 'package:my_store_serverpod_backend_client/my_store_serverpod_backend_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flearn/trello_app_clone_serverpod/utils/trello_provider.dart';

import 'features/aboutboard/presentation/index.dart';
import 'features/archivedcards/presentation/index.dart';
import 'features/archivedlists/presentation/index.dart';
import 'features/board/presentation/index.dart';
import 'features/boardbackground/presentation/index.dart';
import 'features/boardmenu/presentation/index.dart';
import 'features/boardsettings/presentation/index.dart';
import 'features/carddetails/presentation/index.dart';
import 'features/copyboard/presentation/index.dart';
import 'features/createboard/presentation/index.dart';
import 'features/createcard/presentation/index.dart';
import 'features/createworkspace/presentation/index.dart';
import 'features/emailtoboard/presentation/index.dart';
import 'features/home/presentation/index.dart';
import 'features/invitemember/presentation/index.dart';
import 'features/landing/presentation/index.dart';
import 'features/members/presentation/index.dart';
import 'features/mycards/presentation/index.dart';
import 'features/notifications/presentation/index.dart';
import 'features/offlineboards/presentation/index.dart';
import 'features/powerups/presentation/index.dart';
import 'features/settings/presentation/index.dart';
import 'features/signtotrello/presentation/index.dart';
import 'features/workspace/presentation/index.dart';
import 'features/workspacemenu/presentation/index.dart';
import 'features/workspacesettings/presentation/index.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')..connectivityMonitor = FlutterConnectivityMonitor();

TrelloProvider trello = TrelloProvider();

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TrelloProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Ex',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Landing(),
        Home.routeName: (context) => const Home(),
        Notifications.routeName: (context) => const Notifications(),
        WorkspaceMenu.routeName: (context) => const WorkspaceMenu(),
        WorkspaceSettings.routeName: (context) => const WorkspaceSettings(),
        Members.routeName: (context) => const Members(),
        InviteMember.routeName: (context) => const InviteMember(),
        CreateWorkspace.routeName: (context) => const CreateWorkspace(),
        CreateBoard.routeName: (context) => const CreateBoard(),
        BoardBackground.routeName: (context) => const BoardBackground(),
        CreateCard.routeName: (context) => const CreateCard(),
        BoardScreen.routeName: (context) => const BoardScreen(),
        BoardMenu.routeName: (context) => const BoardMenu(),
        CopyBoard.routeName: (context) => const CopyBoard(),
        BoardSettings.routeName: (context) => const BoardSettings(),
        ArchivedLists.routeName: (context) => const ArchivedLists(),
        ArchivedCards.routeName: (context) => const ArchivedCards(),
        EmailToBoard.routeName: (context) => const EmailToBoard(),
        AboutBoard.routeName: (context) => const AboutBoard(),
        PowerUps.routeName: (context) => const PowerUps(),
        CardDetails.routeName: (context) => const CardDetails(),
        MyCards.routeName: (context) => const MyCards(),
        OfflineBoards.routeName: (context) => const OfflineBoards(),
        Settings.routeName: (context) => const Settings(),
        SignToTrello.routeName: (context) => const SignToTrello(),
        WorkspaceScreen.routeName: (context) => const WorkspaceScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
