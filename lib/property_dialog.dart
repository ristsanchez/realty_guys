import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:realty_guys/color_constants.dart';

showPropertyDialog(BuildContext context, var data) {
  return showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (context) => SimpleDialog(
      insetPadding: const EdgeInsets.fromLTRB(48, 74, 48, 0),
      titlePadding: const EdgeInsets.all(0),

      alignment: Alignment.topCenter,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      // contentPadding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.fromLTRB(35, 25, 35, 20),
              height: MediaQuery.of(context).size.width * 0.75,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(.15),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Center(
                        child: Text('Cost \$20',
                            style: TextStyle(color: Colors.white70))),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Center(
                        child: Text('Rent \$2',
                            style: TextStyle(color: Colors.white70))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text('With houses:',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  Expanded(flex: 5, child: Center(child: getHouseColumn(some))),
                  const Expanded(
                    flex: 1,
                    child:
                        Center(child: Text('house cost \$50 / mortgage \$30')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

var some = [1, 2, 3, 4, 5];
getHouseColumn(List rentList) {
  List<Widget> columnOfRows = [];
  List<Widget> temp = [];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < i + 1; j++) {
      temp.add(const Icon(Icons.house, color: Colors.white70));
    }
    temp.insert(temp.length, const Expanded(child: const Center()));
    temp.insert(temp.length, const Text('\$'));

    columnOfRows.insert(columnOfRows.length, Row(children: temp));
    // if (i < 4) {
    columnOfRows.insert(
        columnOfRows.length, const Divider(height: 2, thickness: 1));

    temp = [];
  }
  columnOfRows.insert(0, const Divider(height: 2, thickness: 1));
  return Column(children: columnOfRows);
}
