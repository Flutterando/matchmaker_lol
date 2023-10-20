import 'package:app/app/app_module.dart';
import 'package:app/app/core/presenter/common_widgets/fmm_button.dart';
import 'package:app/app/rift/domain/state/rift_state.dart';
import 'package:app/app/rift/domain/stores/rift_store.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final riftStore = appInjector.get<RiftStore>();

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
      Routefly.navigate('${routePaths.rift.room.path}/${state.room.id}');
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
    riftStore.removeListener(_navigate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: riftStore,
      builder: (_, snapshot) {
        final state = riftStore.value;
        final isLoading = state is LoadingRiftState;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 8,
                  child: Text(
                    'Flutterando\nMatchMaker',
                    style: TextStyle(color: Colors.white, fontSize: 60),
                  ),
                ),
                const Spacer(flex: 2),
                Flexible(
                  flex: 3,
                  child: FMMButton(
                    label: 'Criar',
                    onPressed: isLoading ? null : riftStore.createRoom,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  flex: 3,
                  child: FMMButton(
                    label: 'Entrar',
                    onPressed: isLoading
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                var roomId = '';
                                return AlertDialog.adaptive(
                                  actions: [
                                    Material(
                                      child: TextField(
                                        onChanged: (value) => roomId = value,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (roomId.isEmpty) {
                                              return;
                                            }
                                            Navigator.pop(context);
                                            Routefly.navigate('${routePaths.rift.room.path}/$roomId');
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
