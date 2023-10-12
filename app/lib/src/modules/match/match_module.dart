import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/match_page.dart';
import 'presenter/pages/room_page.dart';

class MatchModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/room/:id', child: (_) => RoomPage());
    r.child('/match', child: (_) => MatchPage());
  }
}
