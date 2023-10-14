import 'package:app/src/modules/match/presenter/pages/room_page.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
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
                        child: ListView(
                          shrinkWrap: true,
                          children: const [
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                          ],
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
                        child: ListView(
                          shrinkWrap: true,
                          children: const [
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                            ConfirmedPlayer(),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
