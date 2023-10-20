import 'package:app/app/core/core_module.dart';
import 'package:auto_injector/auto_injector.dart';

import 'rift/domain/repositories/player_repository.dart';
import 'rift/domain/repositories/rift_repository.dart';
import 'rift/domain/stores/rift_store.dart';
import 'rift/domain/usecases/create_rift.dart';
import 'rift/infra/repositories/firebase_player_repository.dart';
import 'rift/infra/repositories/firebase_rift_repository.dart';

final appInjector = AutoInjector(
  on: (i) {
    i.addInjector(coreInjector);
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

    i.commit();
  },
);
