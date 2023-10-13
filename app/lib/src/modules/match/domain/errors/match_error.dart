abstract class MatchError implements Exception {
  final String message;
  final StackTrace? trace;

  MatchError(this.message, [this.trace]);
}

class MinimalPlayersMatchError extends MatchError {
  MinimalPlayersMatchError() : super('É nessário ter 10 player para iniciar a partida');
}

class RoleMatchError extends MatchError {
  RoleMatchError() : super('Precisa-se diversificar mais os papeis');
}

class NotReadyMatchError extends MatchError {
  NotReadyMatchError() : super('Todos os player precisam está prontos');
}
