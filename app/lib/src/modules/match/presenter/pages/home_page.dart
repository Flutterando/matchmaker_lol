import 'package:app/src/modules/match/domain/state/rift_state.dart';
import 'package:app/src/modules/match/domain/stores/rift_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final riftStore = Modular.get<RiftStore>();

  @override
  void initState() {
    super.initState();
    riftStore.addListener(_navigate);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      riftStore.getPlayer();
    });
  }

  void _navigate() {
    final state = riftStore.value;
    if (state is CreatedRoomRiftState) {
      Modular.to.navigate('./room/${state.room.id}');
    } else if (state is ErrorRiftState) {
      final error = state.error!;
      final snackBar = SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    riftStore.addListener(_navigate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RiftStore>();
    final state = store.value;

    final isLoading = state is LoadingRiftState;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Flutterando',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'MatchMaker',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : store.createRoom,
              child: const Text('Criar'),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          var roomId = '';
                          return AlertDialog.adaptive(
                            actions: [
                              TextField(
                                onChanged: (value) => roomId = value,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (roomId.isEmpty) {
                                        return;
                                      }
                                      Navigator.pop(context);
                                      Modular.to.navigate('./room/$roomId');
                                    },
                                    child: const Text('Entrar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
