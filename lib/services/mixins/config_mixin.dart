import 'package:get_it/get_it.dart';
import 'package:tt_19/services/flagsmith.dart';

mixin ConfigMixin {
  final _flagsmith = GetIt.instance<Flagsmith>();

  String get privacyLink => _flagsmith.config.privacyLink;

  String get termsLink => _flagsmith.config.termsLink;
}
