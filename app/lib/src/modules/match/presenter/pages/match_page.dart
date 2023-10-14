import 'package:app/src/modules/match/domain/entities/team_side.dart';
import 'package:app/src/modules/match/domain/state/rift_state.dart';
import 'package:app/src/modules/match/domain/stores/rift_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final riftStore = Modular.get<RiftStore>();

  @override
  void initState() {
    super.initState();
    riftStore.addListener(listener);
  }

  void listener() {
    if (riftStore.value is! UpdatedRoomRiftState) {
      Modular.to.pop();
    }
  }

  @override
  void dispose() {
    riftStore.removeListener(listener);
    super.dispose();
  }

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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
          Row(
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
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Matchmaker',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 480,
                            height: 500,
                            color: const Color(0XFF1D1B20),
                            padding: const EdgeInsets.all(48),
                            child: ListView.separated(
                              itemCount: blueTeam.length,
                              itemBuilder: (context, index) {
                                final player = blueTeam[index];
                                final showYou = player.id == state.player.id;
                                return ListTile(
                                  title: Text(player.name),
                                  subtitle:
                                      Text(player.role.name.toUpperCase()),
                                  trailing: showYou
                                      ? const Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        )
                                      : null,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
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
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 480,
                            height: 500,
                            color: const Color(0XFF1D1B20),
                            padding: const EdgeInsets.all(48),
                            child: ListView.separated(
                              itemCount: redTeam.length,
                              itemBuilder: (context, index) {
                                final player = redTeam[index];
                                final showYou = player.id == state.player.id;
                                return ListTile(
                                  title: Text(player.name),
                                  subtitle:
                                      Text(player.role.name.toUpperCase()),
                                  trailing: showYou
                                      ? const Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        )
                                      : null,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
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
        ],
      ),
    );
  }
}
