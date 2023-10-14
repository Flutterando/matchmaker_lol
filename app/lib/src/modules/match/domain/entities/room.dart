// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'player.dart';
import 'team.dart';

class Room {
  final String id;
  final Set<Player> players;
  final String hostID;
  final List<Team> teams;

  Room({
    required this.id,
    required this.players,
    required this.hostID,
    required this.teams,
  });

  Room copyWith({
    String? id,
    Set<Player>? players,
    String? hostID,
    List<Team>? teams,
  }) {
    return Room(
      id: id ?? this.id,
      players: players ?? this.players,
      hostID: hostID ?? this.hostID,
      teams: teams ?? this.teams,
    );
  }
}
