import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realty_guys/player.dart';

const int jail = 30;

class Board extends ChangeNotifier {
  // player id and then its position
  late HashMap<int, int> _playerPositions;

  //don't make final

  Board() : _playerPositions = HashMap();

  HashMap<int, int> get getPositions => _playerPositions;

  int getPlayerPosition(int id) => _playerPositions[id] ?? -1;

  void setPositions(HashMap<int, int> positions) {
    _playerPositions = positions;
  }

  void initialize(Set<Player> playerSet) {
    for (Player player in playerSet) {
      _playerPositions.putIfAbsent(player.id, () => 0);
    }
    notifyListeners();
    print('initialized player positions');
  }

  void sendToGoToJail(int playerId) {
    _playerPositions.update(playerId, (value) => jail);
    //notify landing?
    notifyListeners();
  }

  void sendToJail(int playerId) {
    _playerPositions.update(playerId, (value) => jail);
    //notify landing?
    notifyListeners();
  }

  void advance(int playerId, int numberOfSpaces) {
    int currentPosition = _playerPositions[playerId] ?? -1;
    int newPosition = (numberOfSpaces + currentPosition) % 40;

    if (currentPosition < 0) {
      // throw new IllegalArgumentException("Player does not play in the game.");
    } else if (numberOfSpaces <= 0) {
      // throw new IllegalArgumentException("numberOfFields must be positive: " + numberOfFields);
    } else {
      _playerPositions.update(playerId, (value) => newPosition);
      notifyListeners();
      //provider positions?
      //show movement animation?
    }

    //behavior for landing separate? A: yes
  }
}
