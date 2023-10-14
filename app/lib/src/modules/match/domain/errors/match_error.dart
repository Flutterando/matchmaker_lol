import '../entities/room.dart';

abstract class MatchError implements Exception {
  final String message;
  final StackTrace? trace;
  final Room? room;

  MatchError(this.message, {this.room, this.trace});
}

class MinimalPlayersMatchError extends MatchError {
  MinimalPlayersMatchError(super.message, {super.room, super.trace});
}

class RoleMatchError extends MatchError {
  RoleMatchError({super.room, super.trace}) : super('Precisa-se diversificar mais os papeis');
}

class NotReadyMatchError extends MatchError {
  NotReadyMatchError({super.room, super.trace}) : super('Todos os player precisam está prontos');
}
