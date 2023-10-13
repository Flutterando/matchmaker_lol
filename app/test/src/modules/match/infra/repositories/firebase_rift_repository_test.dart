import 'dart:convert';

import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/infra/repositories/firebase_rift_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firebase Firestore', () {
    late FakeFirebaseFirestore db;
    late FirebaseRiftRepository repository;

    setUp(() {
      db = FakeFirebaseFirestore();
      repository = FirebaseRiftRepository(db);
    });

    test('deve adicionar 3 salas ...', () async {
      await repository
          .createRoom(Room(id: 'sala_01', players: {}, hostID: 'flutterando'));
      await repository
          .createRoom(Room(id: 'sala_02', players: {}, hostID: 'kali'));
      await repository
          .createRoom(Room(id: 'sala_03', players: {}, hostID: 'jacob'));

      final data = jsonDecode(db.dump());

      expect(data['rooms'].length, 3);
    });

    test('deve pegar uma sala ...', () async {
      await repository
          .createRoom(Room(id: 'sala_01', players: {}, hostID: 'flutterando'));
      await repository
          .createRoom(Room(id: 'sala_02', players: {}, hostID: 'kali'));
      await repository
          .createRoom(Room(id: 'sala_03', players: {}, hostID: 'jacob'));

      final result = await repository.getRoom('sala_02');

      final room = result.getOrThrow();

      expect(room.hostID, 'kali');
    });

    test('deve atualizar uma sala ...', () async {
      await repository
          .createRoom(Room(id: 'sala_01', players: {}, hostID: 'flutterando'));
      await repository
          .createRoom(Room(id: 'sala_02', players: {}, hostID: 'kali'));
      await repository
          .createRoom(Room(id: 'sala_03', players: {}, hostID: 'jacob'));

      var result = await repository.getRoom('sala_03');

      var room = result.getOrThrow();

      await repository.updateRoom(
        room.copyWith(
          players: {
            Player(id: '1231', name: 'Jacob'),
          },
        ),
      );

      result = await repository.getRoom('sala_03');

      room = result.getOrThrow();

      expect(room.players.length, 1);
    });
  });
}
