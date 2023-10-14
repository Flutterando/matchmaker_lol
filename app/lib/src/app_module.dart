import 'package:flutter_modular/flutter_modular.dart';

import 'modules/match/match_module.dart';
import 'modules/splash/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SplashPage());
    r.module('/match', module: MatchModule());
  }
}
