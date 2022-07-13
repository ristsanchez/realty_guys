import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:realty_guys/color_constants.dart';
import 'package:realty_guys/square.dart';

showPropertyDialog(BuildContext context, var data) {
  var maxX = MediaQuery.of(context).size.width;
  var type = data.group;
  Color dialogColor = getColorFromGroup(data.group);

  Widget temp = const Center();

  if (type == 'special') {
    temp = _getSpecialTileCard(data);
    dialogColor = getColorFromName(data.name);
  } else if (type == 'railRoad') {
    temp = _getRailRoadCard(data);
  } else if (type == 'utility') {
    temp = _getUtilityCard(data);
  } else {
    //property, land
    temp = _getLandPropertyCard(data);
  }
// > 384 maxX * .25
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
        SizedBox(height: maxX * .54, child: temp),
      ],
    ),
  );
}

Widget _getUtilityCard(data) {
  return const Center();
}

Widget _getRailRoadCard(Railroad railRoad) {
  var cost = railRoad.cost;
  var mort = railRoad.cost ~/ 2;

  var rentList = railRoad.rentList;

  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          'Cost \$$cost',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Center(child: _getRailRoadColumn(rentList))),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Text(
          'Mortgage \$$mort',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    ],
  );
}

_getRailRoadColumn(List rentList) {
  List<Widget> columnOfRows = [];
  List<Widget> temp = [];
  for (int i = 0; i < rentList.length; i++) {
    for (int j = 0; j < i + 1; j++) {
      temp.add(const Icon(
        Icons.tram_rounded,
        color: Colors.white60,
      ));
    }
    temp.insert(temp.length, const Expanded(child: Center()));
    temp.insert(
        temp.length,
        Text(
          '\$ ${rentList[i]}',
          style: const TextStyle(color: Colors.white70),
        ));

    columnOfRows.insert(columnOfRows.length, Row(children: temp));
    // if (i < 4) {
    columnOfRows.insert(
        columnOfRows.length, const Divider(height: 2, thickness: 1));

    temp = [];
  }
  columnOfRows.insert(0, const Divider(height: 2, thickness: 1));
  return Column(children: columnOfRows);
}

var temp2 =
    "Advance to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled.\n\n If railRoad is unowned, you may buy it from the Bank.";
Widget _getSpecialTileCard(SpecialTile tile) {
  Widget temp = const Center();
  if (tile.name == 'Chance') {
    temp = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
            flex: 1,
            child: Icon(
              Icons.question_mark_rounded,
              size: 38,
            )),
        Expanded(
            flex: 2,
            child: Text(
              temp2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
              ),
            )),
      ],
    );
  } else if (tile.name == 'Lucky') {
    var temp500 = const Center(
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.question_mark_rounded,
          size: 45,
        ),
      ),
    );
    temp = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.question_mark_rounded,
              size: 40,
              color: lucky,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Text(
              temp2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: luckyText,
              ),
            )),
      ],
    );
  } else if (tile.name == 'Income Tax') {
    temp = const Center(
      child: Icon(
        Icons.payment,
        size: 45,
      ),
    );
  } else if (tile.name == 'Luxury Tax') {
    temp = const Center(
      child: Icon(
        Icons.payment_rounded,
        size: 65,
      ),
    );
  } else if (tile.id == 0) {
    //Go tile
    temp = const Center(
      child: Icon(
        Icons.arrow_forward_sharp,
        size: 65,
      ),
    );
  } else if (tile.id == 10) {
    temp = const Center(
      child: Icon(
        Icons.join_right,
        size: 65,
      ),
    );
  } else if (tile.id == 20) {
    temp = const Center(
      child: Icon(
        Icons.directions_bike_rounded,
        size: 65,
      ),
    );
  } else if (tile.id == 30) {
    temp = const Center(
      child: Icon(
        Icons.sports_gymnastics_rounded,
        size: 65,
      ),
    );
  }

  return temp;
}

_getLandPropertyCard(Land land) {
  var cost = land.cost;
  var rent = land.rent;
  var houseCost = land.houseCost;
  var mort = land.cost ~/ 2;

  var rentList = land.rentList;

  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          'Cost \$$cost',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rent \$$rent',
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              'With houses:',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Center(child: getHouseColumn(rentList))),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          'House cost \$$houseCost',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Text(
          'Mortgage \$$mort',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    ],
  );
}

getHouseColumn(List rentList) {
  var formatter = NumberFormat('#,###');
  List<Widget> columnOfRows = [];
  List<Widget> temp = [];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < i + 1; j++) {
      temp.add(const Icon(
        Icons.house,
        color: Colors.white60,
        size: 18,
      ));
    }
    temp.insert(temp.length, const Expanded(child: Center()));
    temp.insert(
        temp.length,
        Text(
          '\$ ${formatter.format(rentList[i])}',
          style: const TextStyle(color: Colors.white70),
        ));

    columnOfRows.insert(columnOfRows.length, Row(children: temp));
    // if (i < 4) {
    columnOfRows.insert(
        columnOfRows.length, const Divider(height: 2, thickness: 1));

    temp = [];
  }
  columnOfRows.insert(0, const Divider(height: 2, thickness: 1));
  return Column(children: columnOfRows);
}
