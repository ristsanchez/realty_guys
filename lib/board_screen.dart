import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board_ui_movement.dart';
import 'package:realty_guys/board_ui_provider.dart';
import 'package:realty_guys/color_constants.dart';
import 'dart:math' as math;

import 'package:realty_guys/custom_triangle.dart';
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
                  quarterTurns: 2,
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
