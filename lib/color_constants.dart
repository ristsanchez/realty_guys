import 'package:flutter/material.dart';

const Color cornerBaseColor = Colors.white12;

const Color trainBase = Colors.white38;

const Color base = Colors.white12;

final Color lucky = Colors.blue.shade300.withOpacity(.6);
final Color luckyText = Colors.blue.shade100.withOpacity(.7);

const Color backBoard = Color.fromARGB(36, 123, 198, 255);

final Color darkBlue = Colors.blue.shade700.withOpacity(0.4);

final Color green = Colors.greenAccent.shade200.withOpacity(0.6);

final Color yellow = Colors.yellow.withOpacity(0.5);

final Color red = Colors.red.shade400.withOpacity(0.5);

final Color orange = Colors.orangeAccent.shade400.withOpacity(0.5);

final Color pink = Colors.purpleAccent.shade200.withOpacity(0.5);

final Color lightBlue = Colors.lightBlue.shade200.withOpacity(0.7);

final Color brown = Colors.brown.shade300.withOpacity(0.6);

final List<IconData> iconList = [
  Icons.skateboarding,
  Icons.catching_pokemon_rounded,
  Icons.flight,
  Icons.two_wheeler_rounded,
  Icons.security
];
final List<Color> colorList = [
  Colors.white,
  Colors.blueAccent,
  Colors.teal,
  Colors.redAccent,
  Colors.orange,
  Colors.greenAccent
];

Color getColorFromGroup(String group) {
  Color color = Colors.white24;
  if (group == 'darkblue') {
    return darkBlue;
  }

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

Color getColorFromName(String name) {
  Color color = Colors.white10;

  switch (name) {
    case 'Chance':
    case 'Go':
      color = Colors.white24;
      break;
    case 'Lucky':
      color = Colors.blue.shade200.withOpacity(.24);
      break;

    case 'Jail':
      color = Colors.orange.shade700.withOpacity(.4);
      break;
    case 'Parking':
      color = Colors.white24;
      break;
    case 'Go To Jail':
      color = Colors.redAccent.shade400.withOpacity(.4);
      break;
    case 'Luxury Tax':
      color = lightBlue;
      break;
    case 'Income Tax':
      color = brown;
      break;
  }
  return color;
}
