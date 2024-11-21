import 'package:get_it/get_it.dart';
import 'package:tt_19/services/flagsmith.dart';
import 'package:tt_19/services/network_service.dart';

class Locator {
  static Future<void> setServices() async {
    GetIt.I.registerSingletonAsync<Flagsmith>(() => Flagsmith().init());
    await GetIt.I.isReady<Flagsmith>();
    GetIt.I.registerSingleton<NetworkService>(NetworkService());
  }
}
