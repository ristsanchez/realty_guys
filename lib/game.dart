import 'package:flutter/cupertino.dart';
import 'package:realty_guys/board.dart';
import 'package:realty_guys/die.dart';
import 'package:realty_guys/player.dart';

class Game {
  late bool _gameFinished;
  late Board _board;
  late Set<Player> _players;

  late Player _currentPlayer;
  late int _rollAttempt;
  late Die _die;
  late bool goAgain;
  // que of actions

  Game();

  void startGame() {
    _gameFinished = false;
    _players = {};
    _die = Die();

    _players.add(Player(1, 'john'));
    _players.add(Player(2, 'lennon'));

    _board.initialize(_players);

    _currentPlayer = _players.firstWhere((element) => element.id == 1);

    while (!_gameFinished) {
      //current player turn

      //await user actions/ from provider probably
      //auto roll in 30 secs

      _rollDice();

      _gameFinished = true;
    }
    //exit?
  }

  void _rollDice() {
    //set top of que state to rolling?
    int die1 = _die.roll();
    int die2 = _die.roll();

    if (die1 == die2) {
      if (_rollAttempt == 3) {
        //go to jail
        //pass to ui
      } else {
        //regular move
        //go again
        //pass to ui
        goAgain = true;
      }
    } else {
      //regular move
      _board.advance(_currentPlayer, die1 + die2);
      //add timer/ animation to match time
      //pass to ui
    }
  }
}
