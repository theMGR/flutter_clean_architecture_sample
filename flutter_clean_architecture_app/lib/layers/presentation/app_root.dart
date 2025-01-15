import 'package:flearn/bluetooth_ex/flutter_blue_app.dart';
import 'package:flearn/layers/data/character_repository_impl.dart';
import 'package:flearn/layers/data/source/local/local_storage.dart';
import 'package:flearn/layers/data/source/network/api.dart';
import 'package:flearn/layers/domain/usecase/get_all_characters.dart';
import 'package:flearn/layers/presentation/theme.dart';
import 'package:flearn/layers/presentation/using_bloc/app_using_bloc.dart';
import 'package:flearn/layers/presentation/using_cubit/app_using_cubit.dart';
import 'package:flearn/layers/presentation/using_get_it/app_using_get_it.dart';
import 'package:flearn/layers/presentation/using_mobx/app_using_mobx.dart';
import 'package:flearn/layers/presentation/using_provider/app_using_provider.dart';
import 'package:flearn/layers/presentation/using_riverpod/app_using_riverpod.dart';
import 'package:flearn/main.dart';
import 'package:flearn/serverpod_ex/serverpod_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late StateManagementOptions _currentOption;
  late GetAllCharacters _getAllCharacters;
  var themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _currentOption = StateManagementOptions.bloc;

    // Notice:
    //
    // Some state management packages are also D.I. (Dependency Injection)
    // solutions. To avoid polluting this example with unnecessary repetition,
    // we're creating the object instances here and passing them as parameters
    // to each state management's "root" widgets. Then we'll use the library's
    // specific D.I. widget to make the instance accessible to the rest of the
    // widget tree.
    //
    final api = ApiImpl();
    final localStorage = LocalStorageImpl(sharedPreferences: sharedPref);
    final repo = CharacterRepositoryImpl(api: api, localStorage: localStorage);

    _getAllCharacters = GetAllCharacters(repository: repo);
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeDataDynamicSchemeLight(),
      darkTheme: theme.toThemeDataDynamicSchemeDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final tt = Theme.of(context).textTheme;
          final cs = Theme.of(context).colorScheme;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Transform.translate(
                offset: const Offset(10, 0),
                child: Text(
                  'Rick & Morty\n(${getTitleToOption(_currentOption)})',
                  style: tt.headlineLarge!.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
              actions: [
                IconButton(
                  onPressed: () {
                    final useLight = themeMode == ThemeMode.dark ? true : false;
                    handleBrightnessChange(useLight);
                  },
                  icon: const Icon(Icons.light_mode),
                ),
                PopupMenuButton<StateManagementOptions>(
                  onSelected: (value) async {
                    if (value == StateManagementOptions.bluetoothEx) {
                      /*if (await Permission.bluetooth.isGranted == true) {
                        setState(() {
                          _currentOption = value;
                        });
                      } else {
                        Snackbar.show(ABC.b, "Request bluetooth permission", success: false);
                        await Permission.bluetooth.request();
                      }*/
                      setState(() {
                        _currentOption = value;
                      });
                    } else {
                      setState(() {
                        _currentOption = value;
                      });
                    }
                  },
                  itemBuilder: (context) => [
                    _menuEntry(StateManagementOptions.bloc, 'Bloc', themeMode),
                    _menuEntry(StateManagementOptions.cubit, 'Cubit', themeMode),
                    _menuEntry(StateManagementOptions.mobX, 'MobX', themeMode),
                    _menuEntry(StateManagementOptions.getIt, 'GetIT', themeMode),
                    _menuEntry(StateManagementOptions.provider, 'Provider', themeMode),
                    _menuEntry(StateManagementOptions.riverpod, 'Riverpod', themeMode),
                    _menuEntry(StateManagementOptions.bluetoothEx, 'Bluetooth Ex (Blue Plus)', themeMode),
                    _menuEntry(StateManagementOptions.serverPodEx, 'Serverpod Ex', themeMode),
                  ],
                ),
              ],
            ),
            body: _getAppUsing(stateManagement: _currentOption).animate().fadeIn(delay: 1.2.seconds, duration: .7.seconds),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // _Helpers
  // ---------------------------------------------------------------------------

  Widget _getAppUsing({required StateManagementOptions stateManagement}) {
    switch (stateManagement) {
      case (StateManagementOptions.bloc):
        return AppUsingBloc(getAllCharacters: _getAllCharacters);
      case (StateManagementOptions.cubit):
        return AppUsingCubit(getAllCharacters: _getAllCharacters);
      case (StateManagementOptions.mobX):
        return AppUsingMobX(getAllCharacters: _getAllCharacters);
      case (StateManagementOptions.getIt):
        return const AppUsingGetIt();
      case (StateManagementOptions.provider):
        return AppUsingProvider(getAllCharacters: _getAllCharacters);
      case (StateManagementOptions.riverpod):
        return const AppUsingRiverpod();
      case (StateManagementOptions.bluetoothEx):
        return const FlutterBlueApp();
      case (StateManagementOptions.serverPodEx):
        return const ServerPodEx();
      default:
        return Container();
    }
  }

  PopupMenuItem<StateManagementOptions> _menuEntry(StateManagementOptions option, String text, ThemeMode themeMode) {
    final isSelected = _currentOption == option;
    final textTheme = Theme.of(context).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return PopupMenuItem<StateManagementOptions>(
      value: option,
      child: Text(
        isSelected ? 'using $text' : 'use $text',
        style: textTheme.bodyMedium!.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.red
              : themeMode == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
        ),
      ),
    );
  }

  String getTitleToOption(StateManagementOptions option) {
    switch (option) {
      case (StateManagementOptions.bloc):
        return 'BLOC';
      case (StateManagementOptions.cubit):
        return 'Cubit';
      case (StateManagementOptions.mobX):
        return 'MobX';
      case (StateManagementOptions.getIt):
        return 'GetIT';
      case (StateManagementOptions.provider):
        return 'Provider';
      case (StateManagementOptions.riverpod):
        return 'RiverPod';
      case (StateManagementOptions.bluetoothEx):
        return 'Bluetooth Ex (Blue plus)';
        case (StateManagementOptions.serverPodEx):
        return 'ServerPod Ex';
      default:
        return '';
    }
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness == Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }
}
