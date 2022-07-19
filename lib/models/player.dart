import 'package:flutter/material.dart';

class Player {
  //functional
  final int id;
  int money;
  bool isJailed;

  //presentation
  final String name;
  final Color color;
  final IconData iconData;

  Player({
    required this.id,
    required this.name,
    required this.color,
    required this.iconData,
  })  : money = -1,
        isJailed = false;
}
