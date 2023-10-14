import 'package:app/src/modules/core/core_module.dart';
import 'package:app/src/modules/match/domain/repositories/player_repository.dart';
import 'package:app/src/modules/match/domain/repositories/rift_repository.dart';
import 'package:app/src/modules/match/domain/stores/rift_store.dart';
import 'package:app/src/modules/match/domain/usecases/create_rift.dart';
import 'package:app/src/modules/match/infra/repositories/firebase_rift_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'infra/repositories/firebase_player_repository.dart';
import 'presenter/pages/home_page.dart';
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
    i.add<PlayerRepository>(FirebasePlayerRepository.new);
    i.add(CreateRift.new);
    i.addLazySingleton<RiftStore>(
      RiftStore.new,
      config: BindConfig(
        notifier: (value) => value,
        onDispose: (value) => value.dispose(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/room/:id',
        child: (_) => RoomPage(
              roomId: r.args.params['id'],
            ));
    r.child('/match', child: (_) => const MatchPage());
    r.child('/home', child: (_) => const HomePage());
  }
}
