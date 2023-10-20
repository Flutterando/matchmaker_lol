import 'package:flutter/material.dart';

import '../domain/entities/player.dart';

class ConfirmedPlayer extends StatelessWidget {
  final Player player;

  const ConfirmedPlayer({
    required this.player,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                player.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                player.role.name.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
