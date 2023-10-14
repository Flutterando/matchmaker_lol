import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:app/src/modules/match/domain/errors/room_error.dart';
import 'package:app/src/modules/match/domain/repositories/rift_repository.dart';
import 'package:app/src/modules/match/infra/adapters/room_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';

class FirebaseRiftRepository implements RiftRepository {
  FirebaseRiftRepository(this.db);

  final FirebaseFirestore db;

  @override
  AsyncResult<Room, MatchError> getRoom(String roomId) async {
    try {
      return db //
          .collection('rooms')
          .doc(roomId)
          .get()
          .then((event) {
        if (event.data() == null) throw NotExistRoom();
        return RoomAdapter.fromMap(event.data()!);
      }).then(Success.new);
    } on MatchError catch (e) {
      return Failure(e);
    }
  }

  @override
  Stream<Room> getRoomSnapshot(String roomId) {
    return db //
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .map((event) => RoomAdapter.fromMap(event.data() ?? {}));
  }

  @override
  AsyncResult<Room, MatchError> updateRoom(Room room) async {
    await db.collection('rooms').doc(room.id).update(RoomAdapter.toMap(room));

    return room.toSuccess();
  }

  @override
  AsyncResult<Room, MatchError> createRoom(Room room) async {
    await db.collection('rooms').doc(room.id).set(RoomAdapter.toMap(room));

    return room.toSuccess();
  }
}
