import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color cornerBaseColor = Colors.white12;

  static const Color trainBase = Colors.white38;

  static const Color base = Colors.white12;
  static const Color base2 = Colors.white24;

  static final Color lucky = Colors.blue.shade300.withOpacity(.6);

  static final Color luckyText = Colors.blue.shade100.withOpacity(.7);

  static const Color backBoard = Color.fromARGB(36, 123, 198, 255);

  static const Color dialogBarrier = Colors.black12;

  static final Color darkBlue = Colors.blue.shade700.withOpacity(0.4);
  static final Color green = Colors.greenAccent.withOpacity(0.5);
  static final Color yellow = Colors.yellow.withOpacity(0.5);
  static final Color red = Colors.red.shade400.withOpacity(0.5);
  static final Color orange = Colors.orangeAccent.shade400.withOpacity(0.5);
  static final Color pink = Colors.purpleAccent.shade200.withOpacity(0.5);
  static final Color lightBlue = Colors.lightBlue.shade200.withOpacity(0.7);
  static final Color brown = Colors.brown.shade300.withOpacity(0.6);

  static Color payments = Colors.green.shade300;
  static Color toll = Colors.yellow.withOpacity(.6);

  static Color jail = Colors.orange.shade300.withOpacity(.6);

  static final List<IconData> iconList = [
    Icons.skateboarding,
    Icons.catching_pokemon_rounded,
    Icons.flight,
    Icons.two_wheeler_rounded,
    Icons.security
  ];
  static final List<Color> colorList = [
    Colors.white,
    Colors.blueAccent,
    Colors.teal,
    Colors.redAccent,
    Colors.orange,
    Colors.greenAccent
  ];

  static Color getColorFromGroup(String group) {
    Color color = Colors.white24;
    //missing utilities and railroads

    switch (group) {
      case 'darkBlue':
        color = darkBlue;
        break;
      case 'green':
        color = green;
        break;
      case 'yellow':
        color = yellow;
        break;
      case 'red':
        color = red;
        break;
      case 'orange':
        color = orange;
        break;
      case 'pink':
        color = pink;
        break;
      case 'lightBlue':
        color = lightBlue;
        break;
      case 'brown':
        color = brown;
        break;
    }
    return color;
  }

  static Color getColorFromName(String name) {
    Color color = base;

    switch (name) {
      case 'Go':
      case 'Chance':
      case 'Income Tax':
      case 'Parking':
      case 'Luxury Tax':
        color = base2;
        break;
      case 'Lucky':
        color = Colors.blue.shade200.withOpacity(.34);
        break;
      case 'Jail':
        color = jail;
        break;
      case 'Go To Jail':
        color = Colors.redAccent.shade400.withOpacity(.4);
        break;
    }
    return color;
  }
}
