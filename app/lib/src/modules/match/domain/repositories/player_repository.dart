import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class PlayerRepository {
  AsyncResult<Unit, MatchError> enterRoom(Player player, String roomId);
  AsyncResult<Unit, MatchError> leaveRoom(Player player, String roomId);
}
