import 'package:app/src/modules/match/domain/entities/team_side.dart';
import 'package:app/src/modules/match/domain/stores/rift_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/confirmed_player.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    final store = context.watch<RiftStore>();
    final state = store.value;
    final redTeam = state
        .room //
        .teams
        .firstWhere((e) => e.side == TeamSide.red)
        .players
        .toList();
    final blueTeam = state
        .room //
        .teams
        .firstWhere((e) => e.side == TeamSide.blue)
        .players
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      'Flutterando',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Matchmaker',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        child: Text(
                          'Blue Team',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 480,
                        color: const Color(0XFF1D1B20),
                        padding: const EdgeInsets.all(48),
                        child: ListView.builder(
                          itemCount: blueTeam.length,
                          itemBuilder: (context, index) {
                            final player = blueTeam[index];
                            return ConfirmedPlayer(
                              player: player,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(22),
                    width: 2,
                    height: 600,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        child: Text(
                          'Red Team',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 480,
                        color: const Color(0XFF1D1B20),
                        padding: const EdgeInsets.all(48),
                        child: ListView.builder(
                          itemCount: blueTeam.length,
                          itemBuilder: (context, index) {
                            final player = redTeam[index];
                            return ConfirmedPlayer(
                              player: player,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
