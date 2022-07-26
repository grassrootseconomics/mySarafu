import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mysarafu/repository/vault_repository.dart';
import 'package:mysarafu/utils/biometrics.dart';
import 'package:mysarafu/utils/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl
    ..registerLazySingleton<BiometricUtil>(BiometricUtil.new)
    ..registerLazySingleton<VaultRepository>(VaultRepository.new)
    ..registerLazySingleton<SharedPrefsUtil>(SharedPrefsUtil.new)
    ..registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}
