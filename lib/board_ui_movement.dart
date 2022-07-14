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
          Expanded(flex: 9, child: _stretchTile2(index, true)),
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
          Expanded(flex: 9, child: _stretchTile2(index % 10, false)),
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
              flex: 9, child: _stretchTile2(((index % 10) - 10) * -1, true)),
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
              flex: 9, child: _stretchTile2(((index % 10) - 10) * -1, false)),
          const Expanded(flex: 54, child: Center()),
        ],
      );
    default:
  }

  return const Center();
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

_corner2(List<Map> iconDataList, int index, int rotations) {
  List<Widget> temp = [
    ...iconDataList.map((iconDataMap) {
      return Icon(iconDataMap['iconData'], color: iconDataMap['color']);
    })
  ];
  //group into center?

  Widget child;
  if (temp.length > 1) {
    child = temp.first;
  } else {
    //just 1 icon
    child = RotatedBox(quarterTurns: rotations, child: temp.first);
  }

  //define icon default size? A: yes somewhere

  Widget corner = Expanded(
    flex: 9,
    child: child,
  );

  Widget filler = const Expanded(flex: 54, child: Center());
  Widget ali = const Center();
  switch (index) {
    case 0:
      ali = Column(children: [
        Expanded(flex: 9, child: Row(children: [corner, filler])),
        filler
      ]);
      break;
    case 10:
      ali = Column(children: [
        Expanded(flex: 9, child: Row(children: [filler, corner])),
        filler
      ]);
      break;
    case 20:
      ali = Column(children: [
        filler,
        Expanded(flex: 9, child: Row(children: [filler, corner])),
      ]);
      break;
    case 30:
      ali = Column(children: [
        filler,
        Expanded(
            flex: 9,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [corner, filler])),
      ]);
      break;
  }
  return ali;
}

_stretchTile2(int index, bool isRow) {
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
  return isRow ? Row(children: temp) : Column(children: temp);
}

_stretchTile(int index, bool isRow, List<Map> iconDataList, int rotations) {
  // board flex [9, [45/9, 5 each], 9] total of 63
  List<Widget> temp = [
    ...iconDataList.map((iconDataMap) {
      return Icon(iconDataMap['iconData'], color: iconDataMap['color']);
    })
  ];
  Widget child;
  if (temp.length > 1) {
    child = temp.first;
  } else {
    //just 1 icon

    child = RotatedBox(quarterTurns: rotations, child: temp.first);
  }

  int leftFlex = 9;

  leftFlex += ((index - 1) * 5);

  int rightFlex = (63 - 5) - leftFlex;

  List<Widget> long = [
    Expanded(flex: leftFlex, child: const Center()),
    Expanded(flex: 5, child: Center(child: child)),
    Expanded(flex: rightFlex, child: const Center()),
  ];
  return isRow ? Row(children: long) : Column(children: long);
}

playersOnBoard(BuildContext context, HashMap<int, Map> playerIcons,
    HashMap<int, int> playerPositions, int rotations) {
  //current board quarter rotations (clock-wise) needed to leave icons up

  if (playerPositions.isNotEmpty && playerIcons.isNotEmpty) {
    List<Widget> stackLayers = [];

    int difference = playerPositions.entries.toSet().length;

    HashMap<int, List<Map>> groups = HashMap();
    playerPositions.forEach((id, position) {
      groups.putIfAbsent(position, () => []);
    });

    playerIcons.forEach((id, iconDataMap) {
      groups[playerPositions[id]]!.add(iconDataMap);
    });

    if (playerPositions.length != difference) {
      //2 or more players share the same position, group same together

    }
    groups.forEach((index, element) {
      //corner
      if (index % 10 == 0) {
        //Corner
        stackLayers.add(_corner2(element, index, rotations));
      } else if (0 < index && index < 10) {
        stackLayers.add(
          Column(
            children: [
              Expanded(
                  flex: 9,
                  child: _stretchTile(index, true, element, rotations)),
              const Expanded(flex: 54, child: Center()),
            ],
          ),
        );
      } else if (10 < index && index < 20) {
        stackLayers.add(
          Row(
            children: [
              const Expanded(flex: 54, child: Center()),
              Expanded(
                  flex: 9,
                  child: _stretchTile(index % 10, false, element, rotations)),
            ],
          ),
        );
      } else if (20 < index && index < 30) {
        stackLayers.add(
          Column(
            children: [
              const Expanded(flex: 54, child: Center()),
              Expanded(
                flex: 9,
                child: _stretchTile(
                    //remove tens places, subtract 10, get absolute value
                    //this is done to reverse the order from up to down 1st
                    //Normally it goes 0->1->2... this makes it 2<-1<-0 in the UI
                    ((index % 10) - 10) * -1,
                    true,
                    element,
                    rotations),
              ),
            ],
          ),
        );
      } else if (30 < index && index < 40) {
        stackLayers.add(
          Row(
            children: [
              Expanded(
                flex: 9,
                child: _stretchTile(
                    //remove tens places, subtract 10, get absolute value
                    //this is done to reverse the order from left to right 1st
                    //Normally it goes 0->1->2... this makes it 2<-1<-0 in the UI
                    (((index % 10) - 10) * -1),
                    false,
                    element,
                    rotations),
              ),
              const Expanded(flex: 54, child: Center()),
            ],
          ),
        );
      }
    });

    //all been added

    return Stack(children: stackLayers);
  }

  return const Center();
}
