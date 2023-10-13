import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class RiftRepository {
  Stream<Room> getRoomSnapshot(String roomId);
  AsyncResult<Room, MatchError> getRoom(String roomId);
  AsyncResult<Unit, MatchError> updateRoom(Room room);
  AsyncResult<Unit, MatchError> createRoom(Room room);
}
