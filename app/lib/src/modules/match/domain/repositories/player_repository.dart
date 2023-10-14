import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/room.dart';

abstract class PlayerRepository {
  AsyncResult<Room, MatchError> enterRoom(Player player, String roomId);
  AsyncResult<Room, MatchError> update(Player player, String roomId);
  AsyncResult<Room, MatchError> leaveRoom(Player player, String roomId);
  AsyncResult<Player, MatchError> getOrCreateLocalPlayer();
}
