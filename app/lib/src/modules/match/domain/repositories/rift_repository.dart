import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class RiftRepository {
  Stream<Room> getRoomSnapshot(String roomId);
  AsyncResult<Room, MatchError> getRoom(String roomId);
  AsyncResult<Room, MatchError> updateRoom(Room room);
  AsyncResult<Room, MatchError> createRoom(Room room);
}
