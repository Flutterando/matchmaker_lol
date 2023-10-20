import 'package:app/app/rift/domain/entities/player.dart';
import 'package:app/app/rift/domain/entities/role.dart';

abstract class PlayerAdapter {
  static Map<String, dynamic> toMap(Player player) {
    return {
      'id': player.id,
      'isReady': player.isReady,
      'role': player.role.name,
      'name': player.name,
    };
  }

  static Player fromMap(dynamic mapPlayer) {
    return Player(
      id: mapPlayer['id'],
      name: mapPlayer['name'],
      isReady: mapPlayer['isReady'],
      role: Role.values.firstWhere((role) => role.name == mapPlayer['role']),
    );
  }
}
