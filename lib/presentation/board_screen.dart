import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/presentation/board_inner_ring.dart';
import 'package:realty_guys/presentation/board_player_info_widget.dart';
import 'package:realty_guys/presentation/board_ui_movement.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';
import 'package:realty_guys/presentation/property_card_widget.dart';
import 'package:realty_guys/presentation/color_constants.dart';

import 'package:realty_guys/presentation/custom_triangle.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/utils/json_utils.dart';
import 'package:realty_guys/models/player.dart';

import '../dialogs/index.dart';

const int innerFlex = 5;
const int cornerFlex = 1;

bool showPrices = true;

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key, required this.propertyData}) : super(key: key);
  //property data
  final HashMap propertyData;

  static const routeName = '/boardScreen';

  @override
  Widget build(BuildContext context) {
    final double maxX = MediaQuery.of(context).size.width;
    final double maxY = MediaQuery.of(context).size.height;

    int rotations =
        Provider.of<BoardUIProvider>(context, listen: false).rotations;

    double timeLeft = Provider.of<Game>(context, listen: false).timeLeft / 10;

    bool ifGameIsRunning =
        Provider.of<Game>(context, listen: false).isGameGoing;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            Visibility(
              visible: ifGameIsRunning,
              child: LinearProgressIndicator(
                semanticsLabel: 'Time left in turn',
                value: timeLeft,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, ifGameIsRunning ? 0 : 4, 10, 10),
              child: Column(
                children: [
                  topBar(context),
                  RotatedBox(
                    quarterTurns: rotations,
                    child: Container(
                      color: AppColors.backBoard,
                      width: maxX - 20,
                      height: maxX - 20,
                      //Whole board as a Row
                      child: Stack(
                        children: [
                          _getBoard(context, propertyData, rotations),
                          lightUpTile(context, maxX - 20),
                          _playerPiecesOnBoard(context, 4 - rotations),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Visibility(
                    visible: ifGameIsRunning,
                    child: getActionsRow(context),
                  ),
                  const Divider(height: 2),
                  getPlayerInfo(context),
                  const Divider(height: 2),
                  Visibility(
                    visible: !ifGameIsRunning,
                    child: ElevatedButton(
                      onPressed: () {
                        //init game
                        Provider.of<Game>(context, listen: false).startGame();
                      },
                      child: Text('Start game'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getPlayerInfo(BuildContext context) {
  Set<Player> temp = Provider.of<Game>(context, listen: false).playerInfo;
  return playerInfo(temp);
}

_playerPiecesOnBoard(BuildContext context, int rotations) {
//  boardTableTopUI doesn't care about any players fields except id, position, icon

  //hashmap of player id and position
  HashMap<int, int> playerPositions =
      Provider.of<Board>(context, listen: true).getPositions;

//listen should be set to false when the players component is initiated on
//  game build constructor|| see later when introducing disconnections -> AI
  HashMap<int, Map> playerIcons =
      Provider.of<Game>(context, listen: true).playerIcons;

  //render them at respective position
  return playersOnBoard(context, playerIcons, playerPositions, rotations);
}

getActionsRow(BuildContext context) {
  //ADD a house build/sell mortgage do/undo LOCK for confirmation when doing it
  const double btnSize = 40;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Roll the Dice',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              //Call trade method from player?
              Provider.of<Game>(context, listen: false).playerPressedRoll();
            },
            child: const Icon(Icons.casino),
          ),
        ),
      ),
      Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Trade with other players',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              //Call trade method from player?
            },
            child: const Icon(Icons.compare_arrows_rounded),
          ),
        ),
      ),
      Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Build houses',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              //Call trade method from player?
            },
            child: Icon(
              Icons.add_home_outlined,
              color: Colors.green.shade200,
            ),
          ),
        ),
      ),
      Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Sell houses',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              //Call trade method from player?
            },
            child: Stack(
              children: [
                Icon(
                  Icons.add_home_outlined,
                  color: Colors.red.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12),
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red.shade200,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Mortgage properties',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              //Call trade method from player?
            },
            child: const Center(
              child: Icon(
                Icons.list_alt_rounded,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
      Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Tooltip(
          message: 'Unmortgage properties',
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              Provider.of<BoardUIProvider>(context, listen: false).increase();
              //Call trade method from player?
            },
            child: const Center(
              child: Icon(
                Icons.account_balance,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

topBar(BuildContext context) {
  bool showOwner =
      Provider.of<BoardUIProvider>(context, listen: true).ownerVisibility;
  bool showCosts =
      Provider.of<BoardUIProvider>(context, listen: true).costVisibility;

  String curPlayerName =
      Provider.of<Game>(context, listen: false).currentPlayerName;
  int timeLeft = Provider.of<Game>(context, listen: false).timeLeft;
  return Row(
    children: [
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("$curPlayerName's turn")],
      )),
      Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('$timeLeft'),
          )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BoardUIProvider>(context, listen: false)
                .toggleCostsVisibility();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: showCosts ? Colors.white24 : Colors.white10,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                showCosts
                    ? Icons.attach_money_rounded
                    : Icons.money_off_rounded,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BoardUIProvider>(context, listen: false)
                .toggleOwnerVisibility();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: showOwner ? Colors.white24 : Colors.white10,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                showOwner
                    ? Icons.remove_red_eye_outlined
                    : Icons.horizontal_rule_rounded,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BoardUIProvider>(context, listen: false).rotateBoard();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Icon(
                Icons.rotate_90_degrees_cw_rounded,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

_getBoard(BuildContext context, HashMap propertyData, int rotations) {
  return Row(
    children: [
      //FIRST COLUMN
      _getLeftColumn(context, propertyData),
      //MIDDLE COLUMN
      _getCenterColumn(context, propertyData, rotations),
      //LAST COLUMN
      _getRightColumn(context, propertyData),
    ],
  );
}

_getLeftColumn(BuildContext context, HashMap propertyData) {
  return Expanded(
    flex: cornerFlex,
    child: Column(
      children: [
        //GO CORNER; ID : 0 ---------------------------------------------------
        Expanded(
          flex: cornerFlex,
          child: GestureDetector(
            onTap: () {
              //show info dialog
              showTileDialog(context, propertyData[0]);
            },
            child: Container(
              color: AppColors.cornerBaseColor,
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: (45 + 90) / 180 * 3.1416,
                child: const Text(
                  'GO',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        //LEFT COLUMN ------------------------------------------
        Expanded(
          flex: innerFlex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[39]);
                  },
                  child: Container(
                    color: AppColors.darkBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        VerticalDivider(width: 15, thickness: 15)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showTileDialog(context, propertyData[38]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.toll,
                        color: Colors.yellow.shade200.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[37]);
                  },
                  child: Container(
                    color: AppColors.darkBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        VerticalDivider(width: 15, thickness: 15)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[36]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[35]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    color: AppColors.trainBase,
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.tram_rounded,
                        color: Colors.black54,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[34]);
                  },
                  child: Container(
                    color: AppColors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        VerticalDivider(width: 15, thickness: 15)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[33]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue.shade100.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[32]);
                  },
                  child: Container(
                    color: AppColors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        VerticalDivider(width: 15, thickness: 15)
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[31]);
                  },
                  child: Container(
                    color: AppColors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        VerticalDivider(width: 15, thickness: 15)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // GO TO JAIL CORNER ---------------------------------------------------
        Expanded(
          flex: cornerFlex,
          child: GestureDetector(
            onTap: () {
              //show info dialog
              showTileDialog(context, propertyData[30]);
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.center,
              color: AppColors.cornerBaseColor,
              child: Transform.rotate(
                angle: (180) / 180 * 3.1416,
                child: Icon(
                  Icons.block,
                  color: Colors.redAccent.shade400.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Expanded _getCenterColumn(
    BuildContext context, HashMap propertyData, int rotations) {
  bool showRolls =
      Provider.of<BoardUIProvider>(context, listen: false).ownerVisibility;

  int position =
      Provider.of<Game>(context, listen: false).currentPlayerPosition;

  return Expanded(
    flex: innerFlex,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //TOP ROW
        Expanded(
          flex: cornerFlex,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[1]);
                  },
                  child: Container(
                    color: AppColors.brown,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[2]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue.shade100.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[3]);
                  },
                  child: Container(
                    color: AppColors.brown,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[4]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.payments,
                        color: Colors.green.shade200.withOpacity(0.6),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[5]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    color: AppColors.trainBase,
                    child: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.tram_rounded,
                        color: Colors.black54,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[6]);
                  },
                  child: Container(
                    color: AppColors.lightBlue,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[7]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[8]);
                  },
                  child: Container(
                    color: AppColors.lightBlue,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const VerticalDivider(width: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[9]);
                  },
                  child: Container(
                    color: AppColors.lightBlue,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //CENTER ---------------------------------------------------------------
        // current -> dest, gradient?, dots?
        Expanded(
          flex: innerFlex,
          child: showRolls ? getInnerRing(position, rotations) : const Center(),
          // child: Center(child: PropertyCard(color: Colors.blue.withOpacity(.2))),
        ),
        //BOT ROW --------------------------------------------------------------
        Expanded(
          flex: cornerFlex,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[29]);
                  },
                  child: Container(
                    color: AppColors.yellow,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[28]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(Icons.water_drop_outlined,
                          color: Colors.blue.shade200.withOpacity(.6)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[27]);
                  },
                  child: Container(
                    color: AppColors.yellow,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const VerticalDivider(width: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[26]);
                  },
                  child: Container(
                    color: AppColors.yellow,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[25]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    color: AppColors.trainBase,
                    child: const RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.tram_rounded,
                        color: Colors.black54,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[24]);
                  },
                  child: Container(
                    color: AppColors.red,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const VerticalDivider(width: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[23]);
                  },
                  child: Container(
                    color: AppColors.red,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[22]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: const RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showBuyDialog(context, propertyData[21]);
                  },
                  child: Container(
                    color: AppColors.red,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(
                                height: constraints.maxHeight * 0.3,
                                thickness: constraints.maxHeight * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_getRightColumn(BuildContext context, HashMap propertyData) {
  return Expanded(
    flex: cornerFlex,
    child: Column(
      children: [
        Expanded(
          flex: cornerFlex,
          child: GestureDetector(
            onTap: () {
              //show info dialog
              showTileDialog(context, propertyData[10]);
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(bottom: 6, right: 6),
                  child: Transform.rotate(
                    angle: (180) / 180 * 3.1416,
                    child: const Icon(
                      Icons.do_not_step_outlined,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  color: AppColors.cornerBaseColor,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return CustomPaint(
                        size:
                            Size(constraints.maxHeight, constraints.maxHeight),
                        painter: DrawTriangle());
                  }),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: innerFlex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[11]);
                  },
                  child: Container(
                    color: AppColors.pink,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[12]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Colors.yellow.shade200.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[13]);
                  },
                  child: Container(
                    color: AppColors.pink,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Divider(height: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[14]);
                  },
                  child: Container(
                    color: AppColors.pink,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[15]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    color: AppColors.trainBase,
                    child: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.tram_rounded,
                        color: Colors.black54,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[16]);
                  },
                  child: Container(
                    color: AppColors.orange,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[17]);
                  },
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue.shade100.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[18]);
                  },
                  child: Container(
                    color: AppColors.orange,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Divider(height: .2),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showTileDialog(context, propertyData[19]);
                  },
                  child: Container(
                    color: AppColors.orange,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VerticalDivider(
                                width: constraints.maxWidth * 0.3,
                                thickness: constraints.maxWidth * 0.3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: cornerFlex,
          child: GestureDetector(
            onTap: () {
              //show info dialog
              showTileDialog(context, propertyData[20]);
            },
            child: Container(
              alignment: Alignment.center,
              color: AppColors.cornerBaseColor,
              child: Transform.rotate(
                angle: (45 + 270) / 180 * 3.1416,
                child: const Icon(
                  Icons.directions_bike_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
