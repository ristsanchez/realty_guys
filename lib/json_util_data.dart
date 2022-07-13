import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:realty_guys/square.dart';

Future<HashMap> getPropertyData() async {
  String data = await rootBundle.loadString('lib/assets/tile_data.json');
  Map<String, dynamic> map = json.decode(data);

  HashMap boardSpaces = HashMap();
  List anotherTemp = map['properties'];

  for (var element in anotherTemp) {
    if (element['group'] == 'special') {
      boardSpaces.putIfAbsent(
          element['id'], () => SpecialTile.fromJson(element));
    } else if (element['group'] == 'railRoad') {
      boardSpaces.putIfAbsent(element['id'], () => Railroad.fromJson(element));
    } else if (element['group'] == 'utility') {
      boardSpaces.putIfAbsent(element['id'], () => Utility.fromJson(element));
    } else {
      //Properties colored/lands/the ones with houses
      boardSpaces.putIfAbsent(element['id'], () => Land.fromJson(element));
    }
  }
  return boardSpaces;
}
