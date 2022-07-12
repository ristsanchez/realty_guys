import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board_ui_provider.dart';

//current tile
// context, index of tile, size of board
lightUpTile(BuildContext context, double max) {
  int index = Provider.of<BoardUIProvider>(context, listen: true).index;

  //corner
  switch (index) {
    // Corners
    case 0:
    case 10:
    case 20:
    case 30:
      return _corner(index, max);

    //TOP ROW
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
      return Column(
        children: [
          Expanded(flex: 9, child: _stretchTile(index, true)),
          const Expanded(flex: 54, child: Center()),
        ],
      );
    //RIGHT COLUMN
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
      return Row(
        children: [
          const Expanded(flex: 54, child: Center()),
          Expanded(flex: 9, child: _stretchTile(index % 10, false)),
        ],
      );

    //BOTTOM ROW
    case 21:
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
      return Column(
        children: [
          const Expanded(flex: 54, child: Center()),
          Expanded(
              flex: 9, child: _stretchTile(((index % 10) - 10) * -1, true)),
        ],
      );

    //LEFT COLUMN
    case 31:
    case 32:
    case 33:
    case 34:
    case 35:
    case 36:
    case 37:
    case 38:
    case 39:
      return Row(
        children: [
          Expanded(
              flex: 9, child: _stretchTile(((index % 10) - 10) * -1, false)),
          const Expanded(flex: 54, child: Center()),
        ],
      );
    default:
  }

  return const Center(child: Icon(Icons.hourglass_empty_rounded));
}

_corner(int index, double max) {
  List<Alignment> ali = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft
  ];
  return Align(
    alignment: ali[index ~/ 10],
    child: Container(
      height: max * 0.143,
      width: max * 0.143,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withAlpha(80),
            blurRadius: 6.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
    ),
  );
}

_stretchTile(int index, bool row) {
  // board flex [9, [45/9, 5 each], 9] total of 63
  int leftFlex = 9;

  leftFlex += ((index - 1) * 5);

  int rightFlex = (63 - 5) - leftFlex;

  List<Widget> temp = [
    Expanded(flex: leftFlex, child: const Center()),
    Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.yellow.withAlpha(80),
              blurRadius: 6.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
      ),
    ),
    Expanded(flex: rightFlex, child: const Center()),
  ];
  return row ? Row(children: temp) : Column(children: temp);
}

playersOnBoard(BuildContext context, HashMap<Icon, int> players) {
  LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      //corner
      if (index % 10 == 0) {
        //Corner
        return _corner(index, constraints.maxHeight);
      } else if (0 < index && index < 10) {
        return Column(
          children: [
            Expanded(flex: 9, child: _stretchTile(index, true)),
            const Expanded(flex: 54, child: Center()),
          ],
        );
      } else if (10 < index && index < 20) {
        return Row(
          children: [
            const Expanded(flex: 54, child: Center()),
            Expanded(flex: 9, child: _stretchTile(index % 10, false)),
          ],
        );
      } else if (20 < index && index < 30) {
        return Column(
          children: [
            const Expanded(flex: 54, child: Center()),
            Expanded(
                flex: 9, child: _stretchTile(((index % 10) - 10) * -1, true)),
          ],
        );
      } else if (30 < index && index < 40) {
        return Row(
          children: [
            Expanded(
                flex: 9, child: _stretchTile(((index % 10) - 10) * -1, false)),
            const Expanded(flex: 54, child: Center()),
          ],
        );
      }
      return Center();
    },
  );
}
