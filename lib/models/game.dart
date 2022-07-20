import 'dart:collection';

import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/die.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';

class Game {
  //game objects
  HashSet<Player> players;
  List tileData; //property ownership A: at property obj lvl
  Board _board;
  final GameSettings settings;
  final List<LuckCard> chanceCards;
  final List<LuckCard> luckyCards;
  final Die die = Die();

  late int houseCount;
  late int hotelCount;

  Game(
    this.tileData,
    this.chanceCards,
    this.luckyCards,
    this.players,
    this.settings,
  )   : _board = Board(),
        houseCount = settings.houseLimit,
        hotelCount = settings.houseLimit;

  void initPlayers() {
    for (Player player in players) {
      player.money = settings.money;
    }
  }

  Board get board => _board;

  int get numberOfPlayers => players.length;

  Player get anyPlayer => players.first;

  int get roll => die.roll;

  int get timeLimit => settings.timeLimit;

  Player playerById(int id) =>
      players.firstWhere((element) => element.id == id);

  int playerPosition(int playerId) => _board.playerPosition(playerId);

  String playerName(int id) =>
      players.firstWhere((player) => player.id == id).name;

  void advancePlayer(int playerId, int numberOfSpaces) =>
      _board.advance(playerId, numberOfSpaces);

  void sendPlayerToJail(int playerId) {
    _board.sendToGoToJail(playerId);
    playerById(playerId).isJailed = true;
  }

  void payMoney(int amount, collector) => playerById(collector).money += amount;

  void collectMoney(int amount, debtor) => playerById(debtor).money -= amount;
}
