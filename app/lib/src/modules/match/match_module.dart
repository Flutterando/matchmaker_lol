import 'package:app/src/modules/core/core_module.dart';
import 'package:app/src/modules/match/domain/repositories/rift_repository.dart';
import 'package:app/src/modules/match/infra/repositories/firebase_rift_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/match_page.dart';
import 'presenter/pages/room_page.dart';

class MatchModule extends Module {
  @override
  List<Module> get imports => [
    CoreModule(),
  ];

  @override
  void binds(Injector i) {
    i.add<RiftRepository>(FirebaseRiftRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/room/:id', child: (_) => RoomPage());
    r.child('/match', child: (_) => MatchPage());
  }
}
