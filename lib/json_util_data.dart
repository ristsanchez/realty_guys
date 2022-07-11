import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:realty_guys/square.dart';

Future<dynamic> getPropertyData() async {
  String data = await rootBundle.loadString('lib/assets/tile_data.json');
  Map<String, dynamic> map = json.decode(data);

  Map boardSpaces = HashMap();
  List anotherTemp = map['properties'];

  anotherTemp.forEach((element) {
    //do special
    if (element['group'] == 'special') {
    } else if (element['group'] == 'railroad') {
    } else if (element['group'] == 'utilities') {
    } else {
      //Properties colored/lands/the ones with houses
      boardSpaces.putIfAbsent(element['id'], () => Land.fromJson(element));
    }
  });
  return boardSpaces;
}
