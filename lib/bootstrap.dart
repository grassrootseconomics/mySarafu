import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mysarafu/firebase_options.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:mysarafu/utils/service_locator.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<Directory> getConfigDir() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final configDir = p.join(documentsDirectory.path, 'sarafu');
  final directory = Directory(configDir);

  if (directory.existsSync()) {
    return Directory(configDir);
  }
  return Directory(configDir).create();
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.w('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.d('onChange(${bloc.runtimeType})');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.d('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log.e(details);
  };
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setupServiceLocator();
      final storage = await HydratedStorage.build(
        storageDirectory:
            kIsWeb ? HydratedStorage.webStorageDirectory : await getConfigDir(),
      );
      await HydratedBlocOverrides.runZoned(
        () async => runApp(await builder()),
        createStorage: () => storage,
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log.e(error),
  );
}
