import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  int? _value = 1;
  @override
  Widget build(BuildContext context) {
    final roles = <String>['ADC', 'SUP', 'MID', 'JUNGLE', 'TOP', 'RANDOM'];
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
                            child: TextField(
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
                            children: List.generate(roles.length, (index) {
                              return ChoiceChip(
                                label: Text(
                                  roles[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                selectedColor: const Color(0XFF6750A4),
                                selected: _value == index,
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
                                  setState(() {
                                    _value = selected ? index : null;
                                  });
                                },
                              );
                            }),
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.standard,
                            ),
                            child: const Text(
                              'Confirmar',
                            ),
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
                    color: const Color(0XFF1D1B20),
                    padding: const EdgeInsets.all(48),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
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
                        ),
                      ],
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
