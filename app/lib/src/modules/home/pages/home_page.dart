import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [
                  Text(
                    'Flutterando',
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  ),
                  Text(
                    'MatchMaker',
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  FilledButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.standard,
                    ),
                    child: const Text('Criar'),
                  ),
                  FilledButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.standard,
                    ),
                    onPressed: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            backgroundColor: const Color(0XFF2B2930),
                            actions: [
                              const Center(
                                child: Text(
                                  'Digite o código da sala',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  fillColor: const Color(0XFF36343B),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: const ButtonStyle(
                                      visualDensity: VisualDensity.standard,
                                    ),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        color: Color(0XFFD0BCFF),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      visualDensity: VisualDensity.standard,
                                    ),
                                    child: const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        color: Color(0XFFD0BCFF),
                                      ),
                                    ),
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
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
