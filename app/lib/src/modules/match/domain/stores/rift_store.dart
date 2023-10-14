import 'dart:async';

import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/repositories/player_repository.dart';
import 'package:app/src/modules/match/domain/repositories/rift_repository.dart';
import 'package:app/src/modules/match/domain/usecases/create_rift.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../entities/player.dart';
import '../state/rift_state.dart';

class RiftStore extends ValueNotifier<RiftState> {
  final CreateRift createRiftUsecase;
  final PlayerRepository playerRepository;
  final RiftRepository riftRepository;
  StreamSubscription? _subscription;

  RiftStore(
    this.createRiftUsecase,
    this.playerRepository,
    this.riftRepository,
  ) : super(InitRiftState());

  Future<void> getRoom(String roomId) async {
    value = value.setLoading();
    final result = await riftRepository.getRoom(roomId);
    if (result.isError()) {
      value = value.setError(result.exceptionOrNull()!);
      return;
    }

    value = value.createRoom(result.getOrThrow());

    await _subscription?.cancel();
    final roomStream = riftRepository.getRoomSnapshot(roomId);
    _subscription = roomStream.listen((room) {
      final newValue = createRiftUsecase(room).fold(value.setRoom, value.setError);
      value = newValue;
    });
  }

  Future<void> enterRoom() async {
    final newState = await playerRepository //
        .enterRoom(value.player, value.room.id)
        .flatMap(createRiftUsecase.call)
        .fold(value.setRoom, value.setError);

    value = newState;
  }

  Future<void> getPlayer() async {
    if (value is! InitRiftState) {
      return;
    }

    value = value.setLoading();

    final newState = await playerRepository //
        .getOrCreateLocalPlayer()
        .fold(value.setPlayer, value.setError);
    value = newState;
  }

  Timer? debounceTime;

  void updatePlayer(Player player) {
    value = value.setPlayer(player);

    debounceTime?.cancel();

    debounceTime = Timer(const Duration(seconds: 2), () async {
      await playerRepository.update(player, value.room.id);
    });
  }

  Future<void> createRoom() async {
    if (value is UpdatedRoomRiftState) {
      return;
    }
    value = value.setLoading();

    final room = Room(
      id: const Uuid().v4(),
      players: {value.player},
      hostID: value.player.id,
      teams: [],
    );

    final newState = await riftRepository //
        .createRoom(room)
        .fold(value.createRoom, value.setError);
    value = newState;
  }

  Future<void> rematch() async {
    final newValue = await createRiftUsecase //
        .call(value.room)
        .toAsyncResult()
        .flatMap(riftRepository.updateRoom)
        .fold(value.setRoom, value.setError);
    value = newValue;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> kickPlayer(Player player) async {
    await playerRepository.leaveRoom(player, value.room.id);
  }
}
