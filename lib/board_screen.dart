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
            Provider.of<BoardProvider>(context, listen: false).increase();
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
    ],
  );
}

topBar(BuildContext context) {
  bool showOwner =
      Provider.of<BoardProvider>(context, listen: true).ownerVisibility;
  bool showCosts =
      Provider.of<BoardProvider>(context, listen: true).costVisibility;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<BoardProvider>(context, listen: false)
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
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Provider.of<BoardProvider>(context, listen: false)
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
      ],
    ),
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
