import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/models/tile.dart';

abstract class JsonUtils {
  JsonUtils._();

  static Future<List> getPropertyData() async {
    String data = await rootBundle.loadString('lib/assets/tile_data.json');
    Map<String, dynamic> map = json.decode(data);
    List anotherTemp = map['properties'];

    List boardSpaces = [];

    for (var element in anotherTemp) {
      if (element['group'] == 'special') {
        boardSpaces.add(SpecialTile.fromJson(element));
      } else if (element['group'] == 'railroad') {
        boardSpaces.add(Railroad.fromJson(element));
      } else if (element['group'] == 'utility') {
        boardSpaces.add(Utility.fromJson(element));
      } else /*Properties colored/lands/the ones with houses*/ {
        boardSpaces.add(Land.fromJson(element));
      }
    }
    boardSpaces.sort(((a, b) => a.id.compareTo(b.id)));
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

  ///temp method removed later
  static Future<HashSet<Player>> tempPlayers() {
    //init json data? after first build
    HashSet<Player> players = HashSet();

    players.add(Player(
        id: 0, name: 'Yoko', color: Colors.red, iconData: Icons.no_accounts));
    players.add(Player(
        id: 1,
        name: 'John',
        color: Colors.greenAccent.shade700,
        iconData: Icons.piano));

    players.add(Player(
        id: 2,
        name: 'Lennon',
        color: Colors.orangeAccent.shade700,
        iconData: Icons.insert_emoticon));

    return Future.delayed(const Duration(seconds: 4), () {
      return players;
    });
  }
}
