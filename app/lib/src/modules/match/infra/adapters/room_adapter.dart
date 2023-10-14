import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/infra/adapters/player_adapter.dart';
import 'package:app/src/modules/match/infra/adapters/team_adapter.dart';

abstract class RoomAdapter {
  static Map<String, dynamic> toMap(Room room) {
    return {
      'id': room.id,
      'hostId': room.hostID,
      'players': room.players.map(PlayerAdapter.toMap).toList(),
      'teams': room.teams.map(TeamAdapter.toMap).toList(),
    };
  }

  static Room fromMap(Map mapRoom) {
    return Room(
      id: mapRoom['id'],
      hostID: mapRoom['hostId'],
      players: (mapRoom['players'] as List) //
          .map(PlayerAdapter.fromMap)
          .toSet(),
      teams: (mapRoom['teams'] as List) //
          .map(TeamAdapter.fromMap)
          .toList(),
    );
  }
}
