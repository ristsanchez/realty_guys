import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/providers/game_controller.dart';

//movement gets current position and final position?
//players gets all players [positions and icon data]

class MovementLayer extends StatelessWidget {
  const MovementLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PlayersLayer extends StatelessWidget {
  const PlayersLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _playerPiecesOnBoard(BuildContext context, int rotations) {
//  boardTableTopUI doesn't care about any players fields except id, position, icon

    //hashmap of player id and position
    HashMap<int, int> playerPositions =
        Provider.of<Board>(context, listen: true).getPositions;

//listen should be set to false when the players component is initiated on
//  game build constructor|| see later when introducing disconnections -> AI
    HashMap<int, Map> playerIcons =
        Provider.of<GameController>(context, listen: false).playerIcons;

    //render them at respective position
    return playersOnBoard(context, playerIcons, playerPositions, rotations);
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
}
