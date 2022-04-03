import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
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
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.d('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.d('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log.e(details.exceptionAsString(), details.stack);
  };
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final storage = await HydratedStorage.build(
        storageDirectory:
            kIsWeb ? HydratedStorage.webStorageDirectory : await getConfigDir(),
      );
      await HydratedBlocOverrides.runZoned(
        () async => runApp(await builder()),
        storage: storage,
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log.e(error.toString(), stackTrace),
  );
}
