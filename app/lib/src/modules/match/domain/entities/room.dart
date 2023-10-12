// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'player.dart';

class Room {
  final String id;
  final Set<Player> players;
  final String hostID;

  Room({
    required this.id,
    required this.players,
    required this.hostID,
  });

  Room copyWith({
    String? id,
    Set<Player>? players,
    String? hostID,
  }) {
    return Room(
      id: id ?? this.id,
      players: players ?? this.players,
      hostID: hostID ?? this.hostID,
    );
  }
}
