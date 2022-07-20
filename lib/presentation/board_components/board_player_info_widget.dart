import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/providers/game_controller.dart';

class PlayerInfoBar extends StatelessWidget {
  const PlayerInfoBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //we might need order for styling and animations

    return Selector<GameController, Set<Player>>(
      selector: (_, gameController) => gameController.playerInfo,
      builder: (context, playerSet, child) {
        if (playerSet.isEmpty) return const Center();

        List<Widget> list = [];

        for (Player player in playerSet) {
          list.add(_playerInfoSingle(player));
        }
        return Row(children: list);
      },
    );
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
}
