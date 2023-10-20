import 'package:app/app/rift/domain/entities/room.dart';
import 'package:app/app/rift/domain/entities/team.dart';

class Rift {
  final Room room;
  final List<Team> teams;

  Rift({
    required this.room,
    required this.teams,
  });
}
