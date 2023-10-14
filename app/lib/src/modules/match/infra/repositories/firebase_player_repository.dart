import 'dart:convert';

import 'package:app/src/modules/core/services/local_storage/local_storage.dart';
import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:app/src/modules/match/domain/repositories/player_repository.dart';
import 'package:app/src/modules/match/domain/repositories/rift_repository.dart';
import 'package:app/src/modules/match/infra/adapters/player_adapter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/room.dart';

const playerKey = 'PLAYER_KEY';

class FirebasePlayerRepository implements PlayerRepository {
  FirebasePlayerRepository(
    this.localStorage,
    this.riftRepository,
  );

  final LocalStorage localStorage;
  final RiftRepository riftRepository;

  @override
  AsyncResult<Room, MatchError> enterRoom(Player player, String roomId) {
    return riftRepository //
        .getRoom(roomId)
        .map((room) => room.copyWith(players: {...room.players, player}))
        .flatMap(riftRepository.updateRoom);
  }

  @override
  AsyncResult<Player, MatchError> getOrCreateLocalPlayer() async {
    final playerString = await localStorage.getString(playerKey);

    late Player player;

    if (playerString != null) {
      final playerMap = jsonDecode(playerString);
      player = PlayerAdapter.fromMap(playerMap);
    } else {
      player = Player(id: const Uuid().v4(), name: 'Player');
      await saveLocalPlayer(player);
    }

    return Success(player);
  }

  @override
  AsyncResult<Room, MatchError> leaveRoom(Player player, String roomId) async {
    return riftRepository //
        .getRoom(roomId)
        .map((room) => room.copyWith(players: room.players..remove(player)))
        .flatMap(riftRepository.updateRoom);
  }

  @override
  AsyncResult<Room, MatchError> update(Player player, String roomId) async {
    await saveLocalPlayer(player);

    return riftRepository //
        .getRoom(roomId)
        .map(
          (room) => room.copyWith(
            players: room.players
              ..removeWhere((p) => p.id == player.id)
              ..add(player),
          ),
        )
        .flatMap(riftRepository.updateRoom);
  }

  Future<void> saveLocalPlayer(Player player) async {
    final playerMap = PlayerAdapter.toMap(player);
    return localStorage.setString(
      playerKey,
      value: jsonEncode(playerMap),
    );
  }
}
