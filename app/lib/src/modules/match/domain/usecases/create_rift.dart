import 'package:app/src/modules/match/domain/entities/rift.dart';
import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/player.dart';
import '../entities/room.dart';
import '../errors/match_error.dart';

class CreateRift {
  Result<Rift, MatchError> call(Room room) {
    if (room.players.length < 10) {
      return MinimalPlayersMatchError().toFailure();
    }

    if (!_validadeRoles(room.players)) {
      return RoleMatchError().toFailure();
    }

    return Rift(room: room, teams: []).toSuccess();
  }

  bool _validadeRoles(Set<Player> players) {
    final hasMaxAdc = players.where((p) => p.role == Role.adc).length <= 2;
    final hasMaxSup = players.where((p) => p.role == Role.sup).length <= 2;
    final hasMaxMid = players.where((p) => p.role == Role.mid).length <= 2;
    final hasMaxJg = players.where((p) => p.role == Role.jungle).length <= 2;
    final hasMaxTop = players.where((p) => p.role == Role.top).length <= 2;

    return hasMaxAdc && hasMaxSup && hasMaxMid && hasMaxJg && hasMaxTop;
  }
}
