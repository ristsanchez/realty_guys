import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realty_guys/models/player.dart';

class Board extends ChangeNotifier {
  static const int jail = 30;
  // player id and then its position
  late HashMap<int, int> _playerPositions;

  //don't make final

  Board() : _playerPositions = HashMap();

  HashMap<int, int> get getPositions => _playerPositions;

  int playerPosition(int id) => _playerPositions[id] ?? -1;

  void setPositions(HashMap<int, int> positions) {
    _playerPositions = positions;
  }

  void initialize(Set<Player> playerSet) {
    for (Player player in playerSet) {
      _playerPositions.putIfAbsent(player.id, () => 0);
    }
  }

  void sendToGoToJail(int playerId) {
    _playerPositions.update(playerId, (value) => jail);
    //notify landing? A: what let me see
    notifyListeners();
  }

  void sendToJail(int playerId) {
    _playerPositions.update(playerId, (value) => jail);

    notifyListeners();
  }

  void advance(int playerId, int numberOfSpaces) {
    int currentPosition = _playerPositions[playerId] ?? -1;
    int newPosition = (numberOfSpaces + currentPosition) % 40;

    _playerPositions.update(playerId, (value) => newPosition);
    notifyListeners();
  }
}
