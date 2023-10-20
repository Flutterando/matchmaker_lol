import 'package:app/app/rift/domain/entities/team_side.dart';

import 'player.dart';

class Team {
  final TeamSide side;
  final Set<Player> players;

  Team({
    required this.side,
    required this.players,
  });
}
