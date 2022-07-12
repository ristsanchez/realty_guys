import 'package:flutter/material.dart';

class Player {
  int _id;
  int _money;

  late String _name;

  late IconData _playerIconData; // leave
  late Color _playerColor;

  Player(this._id, this._name) : _money = 0;

  int get id => _id;

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
