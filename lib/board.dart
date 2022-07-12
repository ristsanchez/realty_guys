import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realty_guys/player.dart';

class Board extends ChangeNotifier {
  late HashMap<Player, int> _playerPositions; //don't make final

  Board() : _playerPositions = HashMap();

  void addPlayer(Player player) {
    if (_playerPositions.containsKey(player)) {
      // throw new IllegalStateException("Player has already joined the game.");
    } else {
      _playerPositions.putIfAbsent(player, () => 0);
    }
  }

  int getPosition(Player player) {
    return _playerPositions[player] ?? -1;
  }

  HashMap<Icon, int> getAllPositions() {
    HashMap<Icon, int> temp = HashMap();

    _playerPositions.forEach((key, value) {
      temp.putIfAbsent(
          Icon(key.playerIconData, color: key.playerColor), () => value);
    });

    return temp;
  }

  void advance(Player player, int numberOfSpaces) {
    int currentPosition = _playerPositions[player] ?? -1;
    if (currentPosition < 0) {
      // throw new IllegalArgumentException("Player does not play in the game.");
    } else if (numberOfSpaces <= 0) {
      // throw new IllegalArgumentException("numberOfFields must be positive: " + numberOfFields);
    } else {
      _playerPositions.update(
          player, (numberOfSpaces) => (numberOfSpaces + currentPosition));
    }

    //behavior for landing separate?
  }
}
