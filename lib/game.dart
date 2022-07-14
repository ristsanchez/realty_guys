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
  HashMap<int, Map> get playerIcons {
    HashMap<int, Map> temp = HashMap();
    for (Player player in _players) {
      temp.putIfAbsent(
        player.id,
        () => {
          'iconData': player.playerIconData,
          'color': player.playerColor,
        },
      );
    }
    return temp;
  }

    _players.add(Player(1, 'john'));
    _players.add(Player(2, 'lennon'));

    _board.initialize(_players);

    _currentPlayer = _players.firstWhere((element) => element.id == 1);

    //   _gameOn = true;
    // }
    //exit?
  }

  void rollDice() {
    //set top of que state to rolling?
    int die1 = _die.roll();
    int die2 = _die.roll();
    print('roll is $die1 + $die2');

    if (die1 == die2) {
      if (_rollAttempt == 2) {
        //go to jail
        _board.sendToJail(_currentPlayerId);
        _currentPlayerId++;
        _currentPlayerId %= 3;
        _rollAttempt = 0;
        //pass to ui
      } else {
        //regular move
        _board.advance(_currentPlayerId, die1 + die2);
        //go again
        _rollAttempt++;
        //pass to ui
      }
    } else {
      //regular move
      _board.advance(_currentPlayerId, die1 + die2);
      //add timer/ animation to match time
      //pass to ui
      _currentPlayerId++;
      _currentPlayerId %= 3;
      _rollAttempt = 0;
    }

    //this goes into game controller
  }
}


//comment section

//current player turn

      //await user actions/ from provider probably
      //auto roll in 30 secs

      //  scenarios where theres a fixed sequence
      //after rolling display moving animation
      //landing on chance display card
      //relocating from chance card, display movement
      //landing on tax, display card debt animation?
      //
      //  scenarios where the user has to respond
      //trade offered
      //  (after trade initiated)
      //  if trade offered
      //    wait for user decision
      //      if accept
      //        make trade Notify Players
      //        check if player in debt?
      //      else
      //        dismiss trade Notify Players
      //    timer runs out
      //      dismiss trade Notify Players
      //
      //in debt
      //  (after money transaction)
      //  if in debt
      //    wait for user to sell/trade and gain money
      //    after time runs out sell their shit starting from the lowest

      //start turn /roll
      //  Actions -> each has a cancel button
      //    trade
      //    build house
      //      if complete group >= 1 && 1 >= houses available
      //        for all in valid groups
      //          if player money > house cost && houses < 5 && not mortgaged
      //            highlight property
      //        wait for user input
      //        if highlighted clicked
      //          add house on highlighted property
      //          update houses available--
      //          update money
      //          GO TO post build house
      //
      //    sell house
      //      if has houses
      //        for all properties with house
      //          highlight property
      //        wait for user input
      //        if highlighted clicked
      //         sell house on highlighted property
      //          update houses available++
      //          update money
      //          GO TO post sell house
      //
      //    mortgage property
      //      if un-mortgaged properties  >= 1
      //        highlight all  un-mortgaged properties
      //      wait for user input
      //      if highlighted clicked
      //        mortgage property
      //        update money
      //        GO TO post mortgage property
      //
      //    un-mortgage property
      //      if has mortgaged properties
      //        for each in all mortgaged properties
      //          if money > un-mortgage cost
      //            highlight property
      //        wait for user input
      //        if highlighted clicked
      //          repossess property
      //          update money
      //          GO TO post un-mortgage property
      //
      //    !!!Declare bankruptcy
      //      by debt to player
      //
      //      not by debt to player

      // CONDITIONS PRIORITY
      //  sell all houses
      //    BASE ownership
      //      trade
      //      mortgage
      //        trade

      //  timer runs out
      //    auto roll

      //landed on buyable

      //  landing options
      //go +200
      //land property
      //  if it's not owned
      //    buy
      //    auction
      //  else
      //    if own nothing
      //    else pay owner
      //      if property has houses
      //        pay rent with houses
      //      if has all group
      //        pay rent x 2
      //      pay rent

      //chance
      //  get random chance card, resolve action
      //tax -200
      //jailOut nothing
      //parking nothing
      //goToJail relocate and jail them
