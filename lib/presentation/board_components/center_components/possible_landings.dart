import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';
import 'package:realty_guys/providers/game_controller.dart';

class RingRolls extends StatelessWidget {
  const RingRolls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<BoardUIProvider, int>(
      selector: (_, boardUIProvider) => boardUIProvider.rotations,
      builder: (_, rotations, child) {
        return Selector<GameController, int>(
          selector: (_, gameController) => gameController.currentPlayerPosition,
          builder: (_, position, child) {
            return _getInnerRing(position, rotations);
          },
        );
      },
    );
  }
}

_getInnerRing(int position, int rotations) {
  if (position < 0) {
    return const Center();
  }
  //where N:0, E:1, S:2, W:3
  int orientation = position ~/ 10;

  int initialPosition = position % 10;
  // <= 8 full, 9 corner and right, LEADING
  // 9 full, 8 right and corner, TRAILING

  int leadingOffset = initialPosition;
  int leadingWeight = 9 - initialPosition;

  int trailingWeight = initialPosition > 7 ? 8 : initialPosition + 1;
  int trailingOffset = initialPosition > 6 ? 0 : 7 - initialPosition;

  List<Widget> temp = [];
  List<Widget> temp2 = [];

  for (var i = 0; i < leadingWeight; i++) {
    temp.insert(
        i,
        Expanded(
            flex: 1,
            child: Center(
                child: RotatedBox(
                    quarterTurns: -rotations - orientation,
                    child: Text('${i + 1}')))));
  }
  temp.insert(0, Expanded(flex: leadingOffset, child: const Center()));

  for (var i = 0; i < trailingWeight; i++) {
    temp2.insert(
        i,
        Expanded(
            flex: 1,
            child: Center(
                child: RotatedBox(
                    quarterTurns: -rotations - orientation,
                    child: Text('${i + leadingWeight + 3}')))));
  }
  temp2.insert(
      temp2.length, Expanded(flex: trailingOffset, child: const Center()));

  //cutoff should be 11-offset the rest to the column

  return RotatedBox(
    quarterTurns: orientation,
    child: Column(
      children: [
        Expanded(flex: 1, child: Row(children: temp)),
        Expanded(
            flex: 8,
            child: Row(
              children: [
                const Expanded(flex: 8, child: Center()),
                Expanded(
                    child: Column(
                  children: temp2,
                ))
              ],
            )),
      ],
    ),
  );
}
