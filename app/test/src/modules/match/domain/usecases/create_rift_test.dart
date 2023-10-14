import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:app/src/modules/match/domain/usecases/create_rift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar dois times completos com todas as roles preenchidas', () {
    final usecase = CreateRift();

    final room = Room(
      id: 'id',
      teams: [],
      players: {
        Player(id: 'id1', name: 'name1', isReady: true, role: Role.adc),
        Player(id: 'id2', name: 'name2', isReady: true, role: Role.adc),
        Player(id: 'id3', name: 'name3', isReady: true, role: Role.sup),
        Player(id: 'id4', name: 'name4', isReady: true, role: Role.sup),
        Player(id: 'id5', name: 'name5', isReady: true, role: Role.mid),
        Player(id: 'id6', name: 'name6', isReady: true, role: Role.mid),
        Player(id: 'id7', name: 'name7', isReady: true, role: Role.jungle),
        Player(id: 'id8', name: 'name8', isReady: true, role: Role.jungle),
        Player(id: 'id9', name: 'name9', isReady: true, role: Role.top),
        Player(id: 'id10', name: 'name10', isReady: true, role: Role.top),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    final rift = result.getOrThrow();

    expect(rift.teams.length, 2);

    final team1 = rift.teams[0];
    final team2 = rift.teams[1];

    expect(team1.players.length, 5);
    expect(team1.players.any((e) => e.role == Role.adc), true);
    expect(team1.players.any((e) => e.role == Role.sup), true);
    expect(team1.players.any((e) => e.role == Role.mid), true);
    expect(team1.players.any((e) => e.role == Role.top), true);
    expect(team1.players.any((e) => e.role == Role.jungle), true);

    expect(team2.players.length, 5);
    expect(team2.players.any((e) => e.role == Role.adc), true);
    expect(team2.players.any((e) => e.role == Role.sup), true);
    expect(team2.players.any((e) => e.role == Role.mid), true);
    expect(team2.players.any((e) => e.role == Role.top), true);
    expect(team2.players.any((e) => e.role == Role.jungle), true);
  });

  test('Deve retornar um erro se não houver 10 players', () {
    final usecase = CreateRift();

    final room = Room(
      teams: [],
      id: 'id',
      players: {
        Player(id: 'id', name: 'name'),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<MinimalPlayersMatchError>());
  });

  test(
      'Deve retornar um erro se os players tiverem '
      'mais de 2 roles iguais com excessão da Role.ramdom', () {
    final usecase = CreateRift();

    final room = Room(
      teams: [],
      id: 'id',
      players: {
        Player(id: 'id1', name: 'name', role: Role.sup),
        Player(id: 'id2', name: 'name', role: Role.sup),
        Player(id: 'id3', name: 'name', role: Role.sup),
        Player(id: 'id4', name: 'name', role: Role.sup),
        Player(id: 'id5', name: 'name', role: Role.sup),
        Player(id: 'id6', name: 'name', role: Role.sup),
        Player(id: 'id7', name: 'name', role: Role.sup),
        Player(id: 'id8', name: 'name', role: Role.sup),
        Player(id: 'id9', name: 'name', role: Role.sup),
        Player(id: 'id10', name: 'name', role: Role.sup),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<RoleMatchError>());
  });

  test('Dispare um erro se os players não tiverem com isReady true', () {
    final usecase = CreateRift();

    final room = Room(
      teams: [],
      id: 'id',
      players: {
        Player(id: 'id1', name: 'name', isReady: true),
        Player(id: 'id2', name: 'name'),
        Player(id: 'id3', name: 'name', isReady: true),
        Player(id: 'id4', name: 'name', isReady: true),
        Player(id: 'id5', name: 'name', isReady: true),
        Player(id: 'id6', name: 'name', isReady: true),
        Player(id: 'id7', name: 'name', isReady: true),
        Player(id: 'id8', name: 'name', isReady: true),
        Player(id: 'id9', name: 'name', isReady: true),
        Player(id: 'id10', name: 'name', isReady: true),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<NotReadyMatchError>());
  });
}
