import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';

import '../entities/player.dart';

sealed class RiftState {
  final Room room;
  final MatchError? error;
  final Player player;

  RiftState({
    required this.room,
    required this.player,
    this.error,
  });

  RiftState setRoom(Room room) {
    return UpdatedRoomRiftState(
      room: room,
      player: player,
    );
  }

  RiftState createRoom(Room room) {
    return CreatedRoomRiftState(
      room: room,
      error: error,
      player: player,
    );
  }

  RiftState setPlayer(Player player) {
    return UpdatedLocalPlayerRiftState(
      room: room,
      error: error,
      player: player,
    );
  }

  RiftState setError(MatchError error) {
    return ErrorRiftState(
      room: error.room ?? room,
      error: error,
      player: player,
    );
  }

  RiftState setLoading() {
    return LoadingRiftState(
      room: room,
      error: error,
      player: player,
    );
  }
}

class InitRiftState extends RiftState {
  InitRiftState() : super(room: Room.empty(), player: Player(id: '', name: ''));
}

class LoadingRiftState extends RiftState {
  LoadingRiftState({
    required super.room,
    super.error,
    required super.player,
  });
}

class ErrorRiftState extends RiftState {
  ErrorRiftState({
    required super.room,
    super.error,
    required super.player,
  });
}

class UpdatedLocalPlayerRiftState extends RiftState {
  UpdatedLocalPlayerRiftState({
    required super.room,
    super.error,
    required super.player,
  });
}

class CreatedRoomRiftState extends RiftState {
  CreatedRoomRiftState({
    required super.room,
    super.error,
    required super.player,
  });
}

class UpdatedRoomRiftState extends RiftState {
  UpdatedRoomRiftState({
    required super.room,
    super.error,
    required super.player,
  });
}
