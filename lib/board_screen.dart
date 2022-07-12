import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board.dart';
import 'package:realty_guys/board_ui_movement.dart';
import 'package:realty_guys/board_ui_provider.dart';
import 'package:realty_guys/color_constants.dart';
import 'dart:math' as math;

import 'package:realty_guys/custom_triangle.dart';
import 'package:realty_guys/game.dart';
import 'package:realty_guys/json_util_data.dart';
import 'package:realty_guys/property_dialog.dart';

const int majorFlex = 35;
bool showPrices = true;
const double _boardWidth = 360;
const double _boardHeight = 360;

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  static const routeName = '/boardScreen';

  @override
  Widget build(BuildContext context) {
    final double maxX = MediaQuery.of(context).size.width;
    final double maxY = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Container(
            width: maxX,
            height: maxY,
            // color: Colors.white12,
            child: Column(
              children: [
                topBar(context),
                RotatedBox(
                  quarterTurns:
                      Provider.of<BoardUIProvider>(context, listen: false)
                          .rotations,
                  child: Container(
                    width: _boardWidth,
                    height: _boardHeight,
                    color: backBoard,

                    //Whole board as a Row
                    child: Stack(
                      children: [
                        _getBoard(context),
                        lightUpTile(context, _boardHeight),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 15,
                ),
                getActionsRow(context),
                const Divider(
                  height: 5,
                ),
                getPlayer(),
                const Divider(
                  height: 2,
                ),
                getPlayer(),
                const Divider(
                  height: 2,
                ),
                getPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getActionsRow(BuildContext context) {
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
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            primary: Colors.transparent,
          ),
          onPressed: () {
            getPropertyData();
            //Call trade method from player?
          },
          child: const Icon(Icons.compare_arrows_rounded),
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
              getPropertyData();
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BoardUIProvider>(context, listen: false)
                .toggleCostsVisibility();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
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

getPlayer() {
  return ExpansionTile(
    collapsedTextColor: Colors.white38,
    textColor: Colors.white60,
    collapsedBackgroundColor: Colors.white10,
    backgroundColor: Colors.blue.shade200.withOpacity(0.15),
    leading: const Icon(Icons.airplanemode_active_rounded),
    title: const Text('Player Name'),
    trailing: const Text('\$800'),
    children: [const Text("properties")],
  );
}

setV(bool v) {
  showPrices = v;
}

_getBoard(BuildContext context) {
  return Row(
    children: [
      //FIRST COLUMN
      _getLeftColumn(context),

      //MIDDLE COLUMN
      _getCenterColumn(),

      //LAST COLUMN
      _getRightColumn(),
    ],
  );
}

_getLeftColumn(BuildContext context) {
  return Expanded(
    flex: 7,
    child: Column(
      children: [
        //CORNER -----------------------------------------------
        Expanded(
          flex: 7,
          child: GestureDetector(
            onTap: () {
              showPropertyDialog(context, '');
            },
            child: Container(
              color: cornerBaseColor,
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
          flex: majorFlex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //show info dialog
                    showPropertyDialog(context, 'data39');
                  },
                  child: Container(
                    color: darkBlue,
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
                child: Container(
                  color: base,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.toll,
                      color: Colors.yellow.shade200.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: darkBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [VerticalDivider(width: 15, thickness: 15)],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: base,
                  child: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  color: trainBase,
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
              Expanded(
                child: Container(
                  color: green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [VerticalDivider(width: 15, thickness: 15)],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: base,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.blue.shade100.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [VerticalDivider(width: 15, thickness: 15)],
                  ),
                ),
              ),
              const Divider(height: .2),
              Expanded(
                child: Container(
                  color: green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [VerticalDivider(width: 15, thickness: 15)],
                  ),
                ),
              ),
            ],
          ),
        ),

        // GO TO JAIL CORNER ---------------------------------------------------
        Expanded(
          flex: 7,
          child: Container(
            alignment: Alignment.center,
            color: cornerBaseColor,
            child: Transform.rotate(
              angle: (45) / 180 * 3.1416,
              child: Icon(
                Icons.front_hand_outlined,
                color: Colors.red.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

_getCenterColumn() {
  return Expanded(
    flex: majorFlex,
    child: Column(
      children: [
        //TOP ROW
        Expanded(
          flex: 7,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: brown,
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
              Expanded(
                child: Container(
                  color: base,
                  child: RotatedBox(
                    quarterTurns: 0,
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.blue.shade100.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: brown,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  color: base,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  color: trainBase,
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
              Expanded(
                child: Container(
                  color: lightBlue,
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
              Expanded(
                  child: Container(
                color: base,
                child: const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.question_mark_rounded,
                    color: Colors.white70,
                  ),
                ),
              )),
              Expanded(
                child: Container(
                  color: lightBlue,
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
              const VerticalDivider(width: .2),
              Expanded(
                child: Container(
                  color: lightBlue,
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
            ],
          ),
        ),
        //CENTER ---------------------------------------------------------------
        // current -> dest, gradient?, dots?
        Expanded(
          flex: majorFlex,
          child: true
              ? const Center()
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.black,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(
                                  child: const Text('7'),
                                ),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.white12,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const Center(),
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: getNine(false),
                            ),
                          ),
                          const Expanded(
                            flex: 7,
                            child: Center(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: getNine(false),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: getNine(true),
                      ),
                    ),
                  ],
                ),
        ),
        //BOT ROW --------------------------------------------------------------
        Expanded(
          flex: 7,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: yellow,
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
              Expanded(
                child: Container(
                  color: base,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(Icons.water_drop_outlined,
                        color: Colors.blue.shade200.withOpacity(.6)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: yellow,
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
              const VerticalDivider(width: .2),
              Expanded(
                child: Container(
                  color: yellow,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  color: trainBase,
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
              Expanded(
                child: Container(
                  color: red,
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
              const VerticalDivider(width: .2),
              Expanded(
                child: Container(
                  color: red,
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
              Expanded(
                child: Container(
                  color: base,
                  child: const RotatedBox(
                    quarterTurns: 0,
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: red,
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
            ],
          ),
        ),
      ],
    ),
  );
}

_getRightColumn() {
  return Expanded(
    flex: 7,
    child: Column(
      children: [
        Expanded(
          flex: 7,
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
                color: cornerBaseColor,
                child: LayoutBuilder(builder: (context, constraints) {
                  return CustomPaint(
                      size: Size(constraints.maxHeight, constraints.maxHeight),
                      painter: DrawTriangle());
                }),
              ),
            ],
          ),
        ),
        Expanded(
          flex: majorFlex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: pink,
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
              Expanded(
                  child: Container(
                color: base,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Colors.yellow.shade200.withOpacity(0.6),
                  ),
                ),
              )),
              Expanded(
                child: Container(
                  color: pink,
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
              const Divider(height: .2),
              Expanded(
                child: Container(
                  color: pink,
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
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(0),
                color: trainBase,
                child: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.tram_rounded,
                    color: Colors.black54,
                    size: 28,
                  ),
                ),
              )),
              Expanded(
                child: Container(
                  color: orange,
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
              Expanded(
                child: Container(
                  color: base,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.blue.shade100.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: orange,
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
              const Divider(height: .2),
              Expanded(
                child: Container(
                  color: orange,
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
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            alignment: Alignment.center,
            color: cornerBaseColor,
            child: Transform.rotate(
              angle: (45 + 270) / 180 * 3.1416,
              child: const Icon(
                Icons.directions_bike_rounded,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

getNine(bool condition) {
  List<Widget> temp = [];
  var colors = [
    lightBlue,
    pink,
    orange,
    red,
    yellow,
    green,
    darkBlue,
  ];

  colors.forEach((element) {
    temp.add(Expanded(
      flex: 1,
      child: Container(
        color: element,
      ),
    ));
  });
  if (condition) {
    temp.insert(0, const Expanded(flex: 1, child: const Center()));

    temp.insert(temp.length, const Expanded(flex: 1, child: const Center()));
  }
  return temp;
}
