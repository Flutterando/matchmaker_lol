import 'package:app/src/modules/match/domain/entities/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        Modular.to.navigate('./home');
      }
      await riftStore.enterRoom();
    });
  }

  void _navigate() {
    final state = riftStore.value;
    if (state is UpdatedRoomRiftState) {
      Modular.to.navigate('./match');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RiftStore>();
    final state = store.value;
    final players = state.room.players.toList();
    final isOwner = state.player.id == state.room.hostID;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0XFF1D1B20),
                    ),
                    width: 518,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              initialValue: state.player.name,
                              key: Key(state.player.id),
                              onChanged: (value) {
                                final player =
                                    state.player.copyWith(name: value);
                                riftStore.updatePlayer(player);
                              },
                              decoration: InputDecoration(
                                hintText: 'NickName',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                hintStyle: const TextStyle(color: Colors.white),
                                fillColor: const Color(0XFF36343B),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          Wrap(
                            spacing: 5,
                            children:
                                List.generate(Role.values.length, (index) {
                              final role = Role.values[index];
                              return ChoiceChip(
                                label: Text(
                                  role.name.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                selectedColor: const Color(0XFF6750A4),
                                selected: role == state.player.role,
                                padding: const EdgeInsets.all(12),
                                backgroundColor: const Color(0XFF1D1B20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Color(0XFFCAC4D0),
                                    width: 3,
                                  ),
                                ),
                                onSelected: (selected) {
                                  if (selected) {
                                    final player =
                                        state.player.copyWith(role: role);
                                    riftStore.updatePlayer(player);
                                  }
                                },
                              );
                            }),
                          ),
                          if (state is ErrorRiftState)
                            Text(
                              state.error?.message ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          Row(
                            children: [
                              FilledButton(
                                onPressed: () {
                                  final player = state.player
                                      .copyWith(isReady: !state.player.isReady);
                                  riftStore.updatePlayer(player);
                                },
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.standard,
                                ),
                                child: Text(
                                  state.player.isReady
                                      ? 'Confirmado'
                                      : 'Não confirmado',
                                ),
                              ),
                              FilledButton(
                                onPressed: state is UpdatedRoomRiftState
                                    ? () {
                                        Modular.to.pushNamed('./match');
                                      }
                                    : null,
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.standard,
                                ),
                                child: const Text('Match!'),
                              ),
                              if (isOwner)
                                FilledButton(
                                  onPressed: state is UpdatedRoomRiftState
                                      ? riftStore.rematch
                                      : null,
                                  style: const ButtonStyle(
                                    visualDensity: VisualDensity.standard,
                                  ),
                                  child: const Text('Re-Match'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(22),
                    width: 2,
                    height: 600,
                  ),
                  Container(
                    width: 480,
                    height: 500,
                    color: const Color(0XFF1D1B20),
                    padding: const EdgeInsets.all(48),
                    child: ListView.separated(
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        final player = players[index];
                        return ListTile(
                          title: Text(player.name),
                          subtitle: Text(player.role.name.toLowerCase()),
                          trailing: !isOwner && player.id == state.room.hostID
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    riftStore.kickPlayer(player);
                                  },
                                  icon:
                                      const Icon(Icons.delete_forever_outlined),
                                ),
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
                ],
              ),
            ],
          ),
          const Flexible(child: SizedBox()),
        ],
      ),
    );
  }
}

class ConfirmedPlayer extends StatelessWidget {
  const ConfirmedPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 360,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0XFF36343B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Okamael',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'ADC',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Image.network(
            'https://placehold.co/400.png',
            height: 80,
          ),
        ],
      ),
    );
  }
}
