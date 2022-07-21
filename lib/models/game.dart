import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/die.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';

class Game extends ChangeNotifier {
  //game objects

  String val;
  HashSet<Player> players;

  List tileData; //property ownership A: at property obj lvl

  Board board;

  final List<LuckCard> chanceCards;
  final List<LuckCard> luckyCards;
  final Die die = Die();
  final GameSettings settings;

  late final int houseCount;
  late final int hotelCount;

  Game(
    this.tileData,
    this.chanceCards,
    this.luckyCards,
    this.players,
    this.settings,
  )   : board = Board(),
        val = 'default',
        houseCount = settings.houseLimit,
        hotelCount = settings.houseLimit;

  void initBoardPositions() {
    board.initialize(players);
  }

  void initPlayers() {
    val = 'init';
    for (Player player in players) {
      player.money = settings.money;
    }
    notifyListeners();
  }

  HashMap<int, int> get boardPositions => board.getPositions;

  int get numberOfPlayers => players.length;

  Player get anyPlayer => players.first;

  int get roll => die.roll;

  int get timeLimit => settings.timeLimit;

  Player playerById(int id) =>
      players.firstWhere((element) => element.id == id);

  int playerPosition(int playerId) => board.playerPosition(playerId);

  String playerName(int id) =>
      players.firstWhere((player) => player.id == id).name;

  void advancePlayer(int playerId, int numberOfSpaces) =>
      board.advance(playerId, numberOfSpaces);

  void sendPlayerToJail(int playerId) {
    board.sendToGoToJail(playerId);
    playerById(playerId).isJailed = true;
  }

  void payMoney(int amount, collector) => playerById(collector).money += amount;

  void collectMoney(int amount, debtor) => playerById(debtor).money -= amount;
}
