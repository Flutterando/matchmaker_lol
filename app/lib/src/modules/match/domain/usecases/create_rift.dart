import 'package:app/src/modules/match/domain/entities/rift.dart';
import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:app/src/modules/match/domain/entities/team.dart';
import 'package:app/src/modules/match/domain/entities/team_side.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/player.dart';
import '../entities/room.dart';
import '../errors/match_error.dart';

class CreateRift {
  Result<Rift, MatchError> call(Room room) {
    if (room.players.length != 10) {
      return MinimalPlayersMatchError().toFailure();
    }

    if (!_validadeRoles(room.players)) {
      return RoleMatchError().toFailure();
    }

    if (room.players.any((p) => !p.isReady)) {
      return NotReadyMatchError().toFailure();
    }

    final players = room.players.toList()..shuffle();
    final randomPlayers = players.where((p) => p.role == Role.random).toList();

    final redPlayers = fillTeam(players, randomPlayers);
    final bluePlayers = fillTeam(players, randomPlayers);

    final teamRed = Team(
      side: TeamSide.red,
      players: redPlayers.toSet(),
    );

    final teamBlue = Team(
      side: TeamSide.red,
      players: bluePlayers.toSet(),
    );

    return Rift(room: room, teams: [teamRed, teamBlue]).toSuccess();
  }

  List<Player> fillTeam(List<Player> players, List<Player> randomPlayers) {
    final fillPlayers = <Player>[];

    for (final role in Role.values.where((e) => e.name != 'random')) {
      final player = players.firstWhere(
        (p) => p.role == role,
        orElse: () {
          final player = randomPlayers.last;
          randomPlayers.removeLast();
          return player.copyWith(role: role);
        },
      );
      fillPlayers.add(player);
    }

    for (final player in fillPlayers) {
      players.remove(player);
    }

    return fillPlayers;
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
