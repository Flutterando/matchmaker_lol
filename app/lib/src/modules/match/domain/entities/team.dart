import 'package:app/src/modules/match/domain/entities/team_side.dart';

import 'player.dart';

class Team {
  final TeamSide side;
  final Set<Player> players;
  final String hostID;

  Team({
    required this.side,
    required this.hostID,
    required this.players,
  });
}
