import 'package:app/src/modules/match/presenter/pages/match_page.dart';
import 'package:app/src/modules/match/presenter/pages/room_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/pages/home_page.dart';
import 'modules/splash/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    //r.child('/', child: (_) => SplashPage());
    r.child('/', child: (_) => HomePage());
    //r.child('/', child: (_) => MatchPage());
  }
}
