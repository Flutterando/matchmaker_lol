import 'package:app/src/modules/core/presenter/common_widgets/fmm_button.dart';
import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/player.dart';
import '../../domain/state/rift_state.dart';
import '../../domain/stores/rift_store.dart';

class RoomPage extends StatefulWidget {
  final String roomId;
  const RoomPage({super.key, required this.roomId});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final riftStore = Modular.get<RiftStore>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await riftStore.getPlayer();
      await riftStore.getRoom(widget.roomId);
      if (riftStore.value is ErrorRiftState) {
        Modular.to.navigate('../home');
      }
      await riftStore.enterRoom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RiftStore>();
    final state = store.value;
    final players = state.room.players.toList();
    final isOwner = state.player.id == state.room.hostID;

    final hasMatch = state.room.teams.isNotEmpty && state is! ErrorRiftState;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                flex: 3,
                child: Text(
                  'Flutterando\nMatchMaker',
                  style: TextStyle(color: Colors.white, fontSize: 42),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 6,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        // width: 518,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0XFF1D1B20),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: TextFormField(
                                    initialValue: state.player.name,
                                    key: Key(state.player.id),
                                    onChanged: (value) {
                                      final player = state.player.copyWith(name: value);
                                      riftStore.updatePlayer(player);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'NickName',
                                      labelStyle: const TextStyle(color: Colors.white),
                                      hintStyle: const TextStyle(color: Colors.white),
                                      fillColor: const Color(0XFF36343B),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Flexible(
                                  flex: 4,
                                  child: Wrap(
                                    spacing: 5,
                                    children: List.generate(Role.values.length, (index) {
                                      final role = Role.values[index];
                                      return ChoiceChip(
                                        label: Text(
                                          role.name.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        selectedColor: const Color(0XFF6750A4),
                                        selected: role == state.player.role,
                                        padding: const EdgeInsets.all(4),
                                        backgroundColor: const Color(0XFF1D1B20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          side: const BorderSide(
                                            color: Color(0XFFCAC4D0),
                                            width: 3,
                                          ),
                                        ),
                                        onSelected: (selected) {
                                          if (selected) {
                                            final player = state.player.copyWith(role: role);
                                            riftStore.updatePlayer(player);
                                          }
                                        },
                                      );
                                    }),
                                  ),
                                ),
                                const Spacer(),
                                if (state.error != null) ...[
                                  Text(
                                    state.error?.message ?? '',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                                Flexible(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FMMButton(
                                        backgroundColor: state.player.isReady ? Colors.green.shade800 : null,
                                        label: state.player.isReady ? 'Confirmado' : 'Confirmar',
                                        onPressed: () {
                                          final player = state.player.copyWith(
                                            isReady: !state.player.isReady,
                                          );
                                          riftStore.updatePlayer(player);
                                        },
                                      ),
                                      const SizedBox(width: 5),
                                      FMMButton(
                                        label: 'View Match',
                                        onPressed: hasMatch
                                            ? () {
                                                Modular.to.pushNamed('../match');
                                              }
                                            : null,
                                      ),
                                      if (isOwner) ...[
                                        const SizedBox(width: 5),
                                        FMMButton(
                                          label: 'Match!',
                                          onPressed: riftStore.match,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0XFF1D1B20),
                          ),
                          padding: const EdgeInsets.all(48),
                          child: ListView.separated(
                            itemCount: players.length,
                            itemBuilder: (context, index) {
                              final player = players[index];
                              return ListTile(
                                title: Text(player.name),
                                subtitle: Text(player.role.name.toLowerCase()),
                                trailing: _removeButton(state, player),
                                leading: player.isReady
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.access_alarm_sharp,
                                        color: Colors.red,
                                      ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _removeButton(RiftState state, Player player) {
    final isOwner = state.player.id == state.room.hostID;
    final isLocalPlayer = player.id == state.player.id;

    if (!isOwner || isLocalPlayer) {
      return null;
    }

    return IconButton(
      onPressed: () {
        riftStore.kickPlayer(player);
      },
      icon: const Icon(
        Icons.delete_forever_outlined,
      ),
    );
  }
}
