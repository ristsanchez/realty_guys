import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/models/player.dart';

playerInfo(Set<Player> players) {
  if (players.isEmpty) return const Center();

  List<Widget> list = [];

  for (Player player in players) {
    list.add(_playerInfoSingle(player));
  }
  return Row(children: list);
}

Widget _playerInfoSingle(Player player) {
  return Expanded(
    child: Column(
      children: [
        Tooltip(
            message: player.name,
            child: Icon(player.iconData, color: player.color, size: 30)),
        Text('\$${player.money}'),
      ],
    ),
  );
}
