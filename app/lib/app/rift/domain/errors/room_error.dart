import 'package:app/app/rift/domain/errors/match_error.dart';

class ErrorOnCreateRoom extends MatchError {
  ErrorOnCreateRoom() : super('Erro na criação de partida');
}

class ErrorOnUpdateRoom extends MatchError {
  ErrorOnUpdateRoom() : super('Erro ao atualizar a partida');
}

class NotExistRoom extends MatchError {
  NotExistRoom() : super('A sala ainda não foi criada.');
}
