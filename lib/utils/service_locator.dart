import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:my_sarafu/model/db/appdb.dart';
import 'package:my_sarafu/repository/vault_repository.dart';
import 'package:my_sarafu/utils/biometrics.dart';
import 'package:my_sarafu/utils/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<BiometricUtil>(BiometricUtil.new)
    ..registerLazySingleton<VaultRepository>(VaultRepository.new)
    ..registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil())
    ..registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}
