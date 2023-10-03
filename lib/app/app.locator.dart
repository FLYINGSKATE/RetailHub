
import 'package:get_it/get_it.dart';

import '../services/ConnectivityService.dart';
import '../services/localstorage_service.dart';
import '../services/navigation_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => LocalStorageService());
}
