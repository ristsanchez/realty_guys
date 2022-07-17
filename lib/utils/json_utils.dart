import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/tile.dart';

abstract class JsonUtils {
  JsonUtils._();

  static Future<HashMap<int, dynamic>> getPropertyData() async {
    String data = await rootBundle.loadString('lib/assets/tile_data.json');
    Map<String, dynamic> map = json.decode(data);

    HashMap<int, dynamic> boardSpaces = HashMap();
    List anotherTemp = map['properties'];

    for (var element in anotherTemp) {
      if (element['group'] == 'special') {
        boardSpaces.putIfAbsent(
            element['id'], () => SpecialTile.fromJson(element));
      } else if (element['group'] == 'railroad') {
        boardSpaces.putIfAbsent(
            element['id'], () => Railroad.fromJson(element));
      } else if (element['group'] == 'utility') {
        boardSpaces.putIfAbsent(element['id'], () => Utility.fromJson(element));
      } else {
        //Properties colored/lands/the ones with houses
        boardSpaces.putIfAbsent(element['id'], () => Land.fromJson(element));
      }
    }
    return boardSpaces;
  }

  static Future<List<LuckCard>> getLuckyCardsData(String type) async {
    String data = await rootBundle.loadString('lib/assets/tile_data.json');
    Map<String, dynamic> map = json.decode(data);

    List jsonCardList = map[type];
    List<LuckCard> cardList = [];

    for (var jsonCard in jsonCardList) {
      //add chance card to game card que
      cardList.add(LuckCard.fromJson(jsonCard));
    }
    cardList.shuffle();
    return cardList;
    //game will generate a random sequence of card ids of length cardList
    //    notify clients of sequence
    //each time a player lands on chance pop id from stack
    //if stack gets empty remake stack and notify
    //    notify clients of new sequence
    //clients get id of chance card got from socket/net...
    //this way the actual card data is not passed through the network,
    //and client only needs to initialize card with title and id
    //or maybe not
  }
}
