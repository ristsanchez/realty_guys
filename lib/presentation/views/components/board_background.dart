import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/board_components/center_components/inner_ring_stack.dart';
import 'package:realty_guys/presentation/color_constants.dart';

import 'package:realty_guys/utils/custom_triangle.dart';

class BoardBackground extends StatelessWidget {
  const BoardBackground({Key? key}) : super(key: key);

  //to be the layout later on
  final int innerFlex = 5;
  final int cornerFlex = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //FIRST COLUMN
        _getLeftColumn(context),
        //MIDDLE COLUMN
        _getCenterColumn(context),
        //LAST COLUMN
        _getRightColumn(context),
      ],
    );
  }

  _getLeftColumn(BuildContext context) {
    return Expanded(
      flex: cornerFlex,
      child: Column(
        children: [
          //GO CORNER; ID : 0 ---------------------------------------------------
          Expanded(
            flex: cornerFlex,
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

          //LEFT COLUMN ------------------------------------------
          Expanded(
            flex: innerFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                const Divider(height: .2),
                Expanded(
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
              ],
            ),
          ),

          // GO TO JAIL CORNER ---------------------------------------------------
          Expanded(
            flex: cornerFlex,
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
        ],
      ),
    );
  }

  Expanded _getCenterColumn(BuildContext context) {
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                const VerticalDivider(width: .2),
                Expanded(
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
              ],
            ),
          ),
          //CENTER ---------------------------------------------------------------
          // inner center of the board
          Expanded(flex: innerFlex, child: const Center()),
          //BOT ROW --------------------------------------------------------------
          Expanded(
            flex: cornerFlex,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
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
                Expanded(
                  child: Container(
                    color: AppColors.base,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(Icons.water_drop_outlined,
                          color: Colors.blue.shade200.withOpacity(.6)),
                    ),
                  ),
                ),
                Expanded(
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
                const VerticalDivider(width: .2),
                Expanded(
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
                Expanded(
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
                Expanded(
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
                const VerticalDivider(width: .2),
                Expanded(
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
                Expanded(
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
                Expanded(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getRightColumn(BuildContext context) {
    return Expanded(
      flex: cornerFlex,
      child: Column(
        children: [
          Expanded(
            flex: cornerFlex,
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
          Expanded(
            flex: innerFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
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
                Expanded(
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
                Expanded(
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
                const Divider(height: .2),
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                Expanded(
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
                const Divider(height: .2),
                Expanded(
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
              ],
            ),
          ),
          Expanded(
            flex: cornerFlex,
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
        ],
      ),
    );
  }
}
