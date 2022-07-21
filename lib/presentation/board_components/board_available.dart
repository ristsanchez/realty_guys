import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/color_constants.dart';

//movement gets current position and final position?
//players gets all players [positions and icon data]

class AvailableProps extends StatelessWidget {
  const AvailableProps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//the properties available to , mortgage, unmortgage, buy house, sell house
//green or red, buy/sell

    //values from prov
    bool mode = false;
    List<int> indexes = [1, 3, 13, 14, 21, 23, 24, 37, 39, 32];

    if (indexes.isEmpty) {
      //shouldn't be called on empty list
      return const Center();
    }
    List<bool> tiles = List<bool>.filled(40, false, growable: false);

    for (int index in indexes) {
      tiles[index] = true;
    }
    // corner + row/col x4
    //cut offs 1-9: 11-19: 21-29 : 31-39
    //elements    11    9     11      9

    my(bool val) {
      if (!val) return const Expanded(child: Center());
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: mode ? AppColors.actionRed : AppColors.actionGreen,
                blurRadius: 5,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Center(),
        ),
      );
    }

    List<Widget> top = tiles.sublist(1, 10).map((e) => my(e)).toList();

    List<Widget> right = tiles.sublist(11, 20).map((e) => my(e)).toList();

    List<Widget> bot =
        tiles.sublist(21, 30).reversed.map((e) => my(e)).toList();

    List<Widget> left =
        tiles.sublist(31, 40).reversed.map((e) => my(e)).toList();

    //layout
    return Container(
      color: Colors.black45,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Row(children: [
                const Expanded(flex: 1, child: Center()),
                Expanded(flex: 5, child: Row(children: top)),
                const Expanded(flex: 1, child: Center()),
              ])),
          Expanded(
              flex: 5,
              child: Row(children: [
                Expanded(flex: 1, child: Column(children: left)),
                const Expanded(flex: 5, child: Center()),
                Expanded(flex: 1, child: Column(children: right)),
              ])),
          Expanded(
              flex: 1,
              child: Row(children: [
                const Expanded(flex: 1, child: Center()),
                Expanded(flex: 5, child: Row(children: bot)),
                const Expanded(flex: 1, child: Center()),
              ])),
        ],
      ),
    );
  }
}
