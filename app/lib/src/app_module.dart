import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/pages/home_page.dart';
import 'modules/splash/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => SplashPage());
    r.child('/home', child: (_) => HomePage());
  }
}
