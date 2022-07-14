import 'package:flutter/material.dart';

class Player {
  late int id;
  late int _money;

  late String name;

  late IconData _playerIconData; // leave
  late Color _playerColor;

  Player({
    this.id = -1,
    this.name = 'Default',
    color = Colors.red,
  })  : _money = 0,
        _playerColor = color,
        _playerIconData = Icons.cruelty_free_sharp;

  int getMoney() {
    return _money;
  }

  void addMoney(int money) {
    if (money < 0) {
      // throw new IllegalArgumentException("Attempted robbery.");
      return;
    }
    _money += money;
  }

  IconData get playerIconData => _playerIconData;

  set playerIconData(IconData icon) {
    _playerIconData = icon;
  }

  Color get playerColor => _playerColor;

  set playerColor(Color color) {
    _playerColor = color;
  }
}


// roll
// build (houses)
// trade
// mortgage/unmortgaged
