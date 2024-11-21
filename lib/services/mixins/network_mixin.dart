import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:tt_19/services/flagsmith.dart';
import 'package:tt_19/services/network_service.dart';

mixin NetworkMixin {
  final _flagsmith = GetIt.instance<Flagsmith>();
  final _networkService = GetIt.instance<NetworkService>();

  Future<void> checkConnection({
    required VoidCallback onError,
  }) async {
    try {
      await _networkService.init(_flagsmith.config.netApiKey);
    } catch (e) {
      onError.call();
    }
  }

  String get link => _flagsmith.config.data[_networkService.network.code];
  bool get canNavigate =>
      !_flagsmith.config.useMock &&
      (_flagsmith.config.data.containsKey(_networkService.network.code));
}
