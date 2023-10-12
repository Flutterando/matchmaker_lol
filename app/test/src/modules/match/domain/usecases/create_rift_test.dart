import 'package:app/src/modules/match/domain/entities/player.dart';
import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:app/src/modules/match/domain/entities/room.dart';
import 'package:app/src/modules/match/domain/errors/match_error.dart';
import 'package:app/src/modules/match/domain/usecases/create_rift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar um erro se não houver 10 players', () {
    final usecase = CreateRift();

    final room = Room(
      id: 'id',
      players: {
        Player(id: 'id', name: 'name'),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<MinimalPlayersMatchError>());
  });

  test('Deve retornar um erro se os players tiverem mais de 2 roles iguais com excessão da Role.ramdom', () {
    final usecase = CreateRift();

    final room = Room(
      id: 'id',
      players: {
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
        Player(id: 'id', name: 'name', role: Role.sup),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<RoleMatchError>());
  });

  test('Dispare um erro se os players não tiverem com isReady true', () {
    final usecase = CreateRift();

    final room = Room(
      id: 'id',
      players: {
        Player(
          id: 'id',
          name: 'name',
        ),
      },
      hostID: 'hostID',
    );

    final result = usecase(room);

    expect(result.exceptionOrNull(), isA<RoleMatchError>());
  });
}
