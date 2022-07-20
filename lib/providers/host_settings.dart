import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/presentation/color_constants.dart';

/// client join game settings
class GameSettingsProvider extends ChangeNotifier {
  GameSettings gameSettings;

  //later
  //  timer settings
  //  auction settings
  //    ALSO separation of host and client UI/functions

  GameSettingsProvider() : gameSettings = GameSettings();

  bool get auctionMode => gameSettings.auctionMode;
  bool get collectIfJailed => gameSettings.collectIfJailed;

  int get money => gameSettings.money;
  int get time => gameSettings.timeLimit;
  int get playerCount => gameSettings.playerCount;

  int get minMoney => gameSettings.minMoney;
  int get maxMoney => gameSettings.maxMoney;
  int get minTime => gameSettings.minTime;
  int get maxTime => gameSettings.maxTime;
  int get minPlayers => gameSettings.minPlayers;
  int get maxPlayers => gameSettings.maxPlayers;

  void updateMoney(int value) {
    gameSettings.money = value;
    notifyListeners();
  }

  void updateTimer(int value) {
    gameSettings.timeLimit = value;
    notifyListeners();
  }

  void updateMaxPlayers(int value) {
    gameSettings.playerCount = value;
    notifyListeners();
  }

  set auctionMode(bool val) {
    gameSettings.auctionMode = val;
    notifyListeners();
  }

  set collectIfJailed(bool val) {
    gameSettings.collectIfJailed = val;
    notifyListeners();
  }
}
