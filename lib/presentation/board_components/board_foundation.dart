import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/dialogs/buy_property_dialog.dart';
import 'package:realty_guys/dialogs/tile_dialog.dart';
import 'package:realty_guys/presentation/board_components/center_components/inner_ring_stack.dart';
import 'package:realty_guys/presentation/color_constants.dart';

import 'package:realty_guys/utils/custom_triangle.dart';
import 'package:realty_guys/providers/game_controller.dart';

class BoardFoundation extends StatelessWidget {
  const BoardFoundation({Key? key}) : super(key: key);
  static const routeName = '/boardScreen';

  //to be the layout later on
  final int innerFlex = 5;
  final int cornerFlex = 1;

  @override
  Widget build(BuildContext context) {
    final List tileData =
        Provider.of<GameController>(context, listen: false).tileData;

    return Row(
      children: [
        //FIRST COLUMN
        _getLeftColumn(context, tileData),
        //MIDDLE COLUMN
        _getCenterColumn(context, tileData),
        //LAST COLUMN
        _getRightColumn(context, tileData),
      ],
    );
  }

  _getLeftColumn(BuildContext context, List squareData) {
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
                showTileDialog(context, squareData[0]);
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
                      showTileDialog(context, squareData[39]);
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
                      showTileDialog(context, squareData[38]);
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
                      showTileDialog(context, squareData[37]);
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
                      showTileDialog(context, squareData[36]);
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
                      showTileDialog(context, squareData[35]);
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
                      showTileDialog(context, squareData[34]);
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
                      showTileDialog(context, squareData[33]);
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
                      showTileDialog(context, squareData[32]);
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
                      showTileDialog(context, squareData[31]);
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
                showTileDialog(context, squareData[30]);
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

  Expanded _getCenterColumn(BuildContext context, List squareData) {
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
                      showTileDialog(context, squareData[1]);
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
                      showTileDialog(context, squareData[2]);
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
                      showTileDialog(context, squareData[3]);
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
                      showTileDialog(context, squareData[4]);
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
                      showTileDialog(context, squareData[5]);
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
                      showTileDialog(context, squareData[6]);
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
                      showTileDialog(context, squareData[7]);
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
                      showTileDialog(context, squareData[8]);
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
                      showTileDialog(context, squareData[9]);
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
          // inner center of the board
          Expanded(flex: innerFlex, child: const InnerRingStack()),
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
                      showTileDialog(context, squareData[29]);
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
                      showTileDialog(context, squareData[28]);
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
                      showTileDialog(context, squareData[27]);
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
                      showTileDialog(context, squareData[26]);
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
                      showTileDialog(context, squareData[25]);
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
                      showTileDialog(context, squareData[24]);
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
                      showTileDialog(context, squareData[23]);
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
                      showTileDialog(context, squareData[22]);
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
                      showBuyDialog(context, squareData[21]);
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

  _getRightColumn(BuildContext context, List squareData) {
    return Expanded(
      flex: cornerFlex,
      child: Column(
        children: [
          Expanded(
            flex: cornerFlex,
            child: GestureDetector(
              onTap: () {
                //show info dialog
                showTileDialog(context, squareData[10]);
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
                          size: Size(
                              constraints.maxHeight, constraints.maxHeight),
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
                      showTileDialog(context, squareData[11]);
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
                      showTileDialog(context, squareData[12]);
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
                      showTileDialog(context, squareData[13]);
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
                      showTileDialog(context, squareData[14]);
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
                      showTileDialog(context, squareData[15]);
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
                      showTileDialog(context, squareData[16]);
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
                      showTileDialog(context, squareData[17]);
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
                      showTileDialog(context, squareData[18]);
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
                      showTileDialog(context, squareData[19]);
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
                showTileDialog(context, squareData[20]);
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
}
