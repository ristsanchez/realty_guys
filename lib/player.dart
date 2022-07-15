import 'package:flutter/material.dart';

class Player {
  late final int _id;
  late final String _name;

  late int _money;
  bool _isJailed = false;

  late Color color;
  late IconData iconData;

  Player({
    id = -1,
    name = 'Default',
    this.color = Colors.red,
    this.iconData = Icons.attachment_outlined,
  })  : _id = id,
        _name = name,
        _money = 0;

  int get id => _id;

  int get money => _money;

  bool get isJailed => _isJailed;

  String get name => _name;

  void addMoney(int money) => _money += money;

  void takeMoney(int money) => _money -= money;

  void sendToJail() => _isJailed = true;

  void getOutOfJail() => _isJailed = false;
}


// roll
// build (houses)
// trade
// mortgage/unmortgaged
