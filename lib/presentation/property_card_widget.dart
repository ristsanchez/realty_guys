import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/models/tile.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({Key? key, required this.propertyData}) : super(key: key);
  final dynamic propertyData;

  @override
  Widget build(BuildContext context) {
    //to ignore constraints wrap in expanded
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: AppColors.getColorFromGroup(propertyData.group),
      ),
      constraints:
          BoardConstraints.cardConstraints(MediaQuery.of(context).size.width),
      child: _getPropertySubClassWidget(),
    );
  }

  _getPropertySubClassWidget() {
    if (propertyData is Railroad) {
      return _getRailRoadCard();
    } else if (propertyData is Utility) {
      return _getUtilityCard();
    } else if (propertyData is Land) {
      //property, land
      return _getLandPropertyCard();
    }
    return const Center();
  }

  Widget _getUtilityCard() {
    return const Center();
  }

  Widget _getRailRoadCard() {
    var cost = propertyData.cost;
    var mort = propertyData.cost ~/ 2;

    var rentList = propertyData.rentList;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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

  Widget _getRailRoadColumn(List rentList) {
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

  Widget _getLandPropertyCard() {
    Land land = propertyData;
    int cost = land.cost;
    int rent = land.rent;
    int houseCost = land.houseCost;
    int mort = land.cost ~/ 2;

    List<int> rentList = land.rentList;

    return Column(
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
            child: Center(child: _getHouseColumn(rentList))),
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

  Widget _getHouseColumn(List rentList) {
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
}
