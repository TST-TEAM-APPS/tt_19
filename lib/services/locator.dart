import 'package:get_it/get_it.dart';
import 'package:tt_19/services/flagsmith.dart';

class Locator {
  static Future<void> setServices() async {
    GetIt.I.registerLazySingletonAsync<Flagsmith>(() => Flagsmith().init());
    await GetIt.I.isReady();
  }
}
