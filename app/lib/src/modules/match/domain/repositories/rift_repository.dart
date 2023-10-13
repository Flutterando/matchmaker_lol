import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class RiftRepository {
  Stream<Room> getRoom(String roomId);
  AsyncResult<Unit, MatchError> updateRoom(Room room);
}
