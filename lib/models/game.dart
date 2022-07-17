import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/die.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/models/tile.dart';

class Game extends ChangeNotifier {
  late Board _board;
  late Set<Player> _players;

  ///
  late final HashMap<int, dynamic> _tileData;
  //idk we shall see
  late Map<int, int> _ownerData;

  final List<LuckCard> _chanceCards;
  final List<LuckCard> _luckyCards;

  final Die _die = Die();

  late int _rollAttempt;
  late bool _isGameGoing;

  late int _oldPosition;

  late int _currentPlayerId;

  late Timer timer;

  Board get board => _board;
  set board(Board b) => _board = b;

  Set<Player> get playerInfo => _players;

  int get currentPlayerPosition =>
      _board.getPlayerPosition(_currentPlayerId); //dep

  String get currentPlayerName =>
      _players.firstWhere((player) => player.id == _currentPlayerId).name;

  int get rollAttempt => _rollAttempt;
  bool get isGameGoing => _isGameGoing;

  //property id and player id
  Map<int, int> get propertyOwnerInfo {
    Map<int, int> list = {};
    _tileData.forEach((id, tileOrProp) {
      if (tileOrProp is Property) {
        list.putIfAbsent(id, () => tileOrProp.ownerId);
      }
    });
    return {};
  }

  HashMap<int, Map> get playerIcons {
    HashMap<int, Map> temp = HashMap();
    for (Player player in _players) {
      temp.putIfAbsent(
        player.id,
        () => {
          'iconData': player.iconData,
          'color': player.color,
        },
      );
    }
    return temp;
  }

  int timeLeft = 0;

  Game(
    this._board,
    this._tileData,
    this._chanceCards,
    this._luckyCards,
    this._players,
  )   : _rollAttempt = 0,
        _currentPlayerId = 0,
        _isGameGoing = false,
        _ownerData = {for (var i = 0; i < 40; i++) i: -1};
  //    ^ this is the default setting, no one owns a property

  void initGame() {
    _board.initialize(_players);
    for (Player player in _players) {
      player.addMoney(1500);
    }
    _currentPlayerId = _players.firstWhere((element) => element.id == 0).id;
  }

  void startGame() {
    _isGameGoing = true;
    notifyListeners();
    startTurn();
  }

  void startTurn() {
    timeLeft = 10;
    //user can trade/sell/buy, etc

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timeLeft <= 0) {
        rollDice();

        timeLeft = 10;
      } else {
        timeLeft--;
      }
      notifyListeners();
    });
    //resolve landing
  }

  void playerPressedRoll() {
    timer.cancel();
    rollDice();

    startTurn();
  }

  void _updateCurrentPlayer() {
    _currentPlayerId++;
    _currentPlayerId %= _players.length;
    notifyListeners();
  }

  void rollDice() {
    //set top of que state to rolling?
    int die1 = _die.roll();
    int die2 = _die.roll();

    //set doubles to false
    if (die1 == die2) {
      if (_rollAttempt == 2) {
        //go to jail
        _board.sendToGoToJail(_currentPlayerId);

        _rollAttempt = 0;
        _updateCurrentPlayer();
        //pass to ui
      } else {
        //regular move
        _board.advance(_currentPlayerId, die1 + die2);
        //go again
        _rollAttempt++;
        //pass to ui
      }
      //set doubles to true
    } else {
      _board.advance(_currentPlayerId, die1 + die2);
      // resolveLanding(currentPlayerPosition, currentPlayerPosition + die2 + die1);
      //add timer/ animation to match time
      //pass to ui
      _rollAttempt = 0;
      _updateCurrentPlayer();
    }
  }

  void resolveLanding(int oldPosition, int newPosition) {
    Player _currentPlayer = Player();
    int currentPlayerId = 0;
    var tileType = _tileData[newPosition].group;

    // passed go, landing on it handled separately
    if (currentPlayerPosition > 0 && _oldPosition < 40) {
      //collect $200
      _pay(200, collector: currentPlayerId);
    }

    if (tileType == 'special') {
      //not buyable
      SpecialTile tile = _tileData[newPosition];

      //landed on go
      if (tile.id == 0) {
        _pay(200, collector: currentPlayerId);
      }
      //landed on chance tile
      else if (tile.name == 'Chance') {
        //get random chance card and resolve effect
      }
      //landed on lucky tile
      else if (tile.name == 'Lucky') {
        //get random lucky card and resolve effect
      }
      //landed on an income/luxury tax tile
      else if (tile.id == 4 || tile.id == 38) {
        //pay 200 to bank, aka the payments void
        _pay(200, debtor: currentPlayerId);
      }
      //landed on just-visiting/jail
      else if (tile.id == 10) {
      }
      //landed on free parking
      else if (tile.id == 20) {
        //depending on settings e.g., players collect accumulated taxes
      }
      //landed on go to jail
      else if (tile.id == 30) {
        //send to jail tile
        _board.sendToJail(currentPlayerId);
        _players
            .firstWhere((player) => player.id == currentPlayerId)
            .sendToJail();
      }
      //all special tiles covered
    } else {
      //landed on Property
      Property property = _tileData[newPosition];

      //If the property doesn't have an owner
      if (!property.hasOwner) {
        //if player can afford the property
        if (_currentPlayer.money > property.cost) {
          //enable buy option in the UI
          // await player input
          var playerSelectedBuy;
          if (playerSelectedBuy) {
            //property set owner to current player id
            //FIND where to get the notify for the UI
          }
        } else {
          //check auction settings
          //auction
        }
      }
      //Property has an owner
      else {
        //player is not the owner of property
        if (currentPlayerId != property.ownerId) {
          //If property is not mortgaged
          if (!property.isMortgaged) {
            //pay accordingly
            if (property.group == 'railroad') {
              //check how many railroad cards owner has
            } else if (property.group == 'utility') {
              //check if whole group owned
              //check roll to calculate rent roll * 4(1 owned) or 10(2 owned)
            } else {
              //regular land
              Land land = _tileData[newPosition];
              //check if land has houses
              if (land.hasHouses) {
                _pay(land.rentWithHouses,
                    collector: land.ownerId, debtor: currentPlayerId);
              }
              //if owner has all from group
              else if (1 == 2) {
                _pay(land.rent * 2,
                    collector: land.ownerId, debtor: currentPlayerId);
              }
              //regular rent
              _pay(land.rent, collector: land.ownerId, debtor: currentPlayerId);
            }
            //payed to owner: land rent
          }
          //didn't pay: mortgaged property
        }
        //didn't pay: own property
      }
      //regular property, buyable
    }
  }

  void _pay(int amount, {int collector = -1, int debtor = -1}) {
    if (collector > -1) {
      _players.firstWhere((player) => player.id == collector).addMoney(amount);
    }
    if (debtor > -1) {
      _players.firstWhere((player) => player.id == debtor).takeMoney(amount);
    }
    //notify each player in the UI
  }

  void setPlayerOrder() {
    //timer 20 secs
    // wait for user rolls
    //all roll
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
