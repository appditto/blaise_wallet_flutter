import 'package:blaise_wallet_flutter/util/pascal_util.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:get_it/get_it.dart';

/// Service locator that provides various singletons
GetIt sl = new GetIt();

void setupServiceLocator() {
  sl.registerLazySingleton<PascalUtil>(() => PascalUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
}