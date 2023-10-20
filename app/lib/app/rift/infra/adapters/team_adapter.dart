import 'package:app/app/rift/domain/entities/team.dart';
import 'package:app/app/rift/domain/entities/team_side.dart';

import 'player_adapter.dart';

abstract class TeamAdapter {
  static Map<String, dynamic> toMap(Team team) {
    return {
      'side': team.side.name,
      'players': team.players.map(PlayerAdapter.toMap).toList(),
    };
  }

  static Team fromMap(dynamic mapRoom) {
    return Team(
      side: TeamSide.values.firstWhere((element) => element.name == mapRoom['side']),
      players: (mapRoom['players'] as List) //
          .map(PlayerAdapter.fromMap)
          .toSet(),
    );
  }
}
