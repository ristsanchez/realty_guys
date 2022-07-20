import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/models/tile.dart';

///Game Controller for local 'pass and play' (single device)
class GameController extends ChangeNotifier {
  Game _game;
  //_game data

  Player currentPlayer;
  int currentPlayerId;

  int _rollAttempt;

  bool _isGameGoing;

  late int timeLeft;
  late Timer timer;

  late int _oldPosition; //???

  Board get board => _game.board;

  List get tileData => _game.tileData;

  int get totalTime => _game.timeLimit;

  int get rollAttempt => _rollAttempt;
  bool get isGameGoing => _isGameGoing;

  Set<Player> get playerInfo => _game.players;

  int get currentPlayerPosition => _game.playerPosition(currentPlayer.id);

  String get currentPlayerName => _game.playerName(currentPlayer.id);

  GameController(this._game)
      : _isGameGoing = false,
        _rollAttempt = 0,
        currentPlayerId = 0,
        currentPlayer = _game.playerById(0),
        timeLeft = 0;

  HashMap<int, Map> get playerIcons {
    HashMap<int, Map> temp = HashMap();
    for (Player player in _game.players) {
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

  void setPlayerOrder() {
    // all players roll, assign order

    //timer 20 secs
    // wait for user rolls
    //all roll
  }

  void _updateCurrentPlayer() {
    currentPlayerId++;
    currentPlayerId %= _game.numberOfPlayers;
    currentPlayer = _game.playerById(currentPlayerId);
    notifyListeners();
  }

  void startGame() {
    _isGameGoing = true;
    _game.initPlayers();
    notifyListeners();
    startTurn();
  }

  void startTurn() {
    timeLeft = _game.timeLimit;

    //user can trade/sell/buy, etc
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timeLeft <= 0) {
        rollDice();
        timer.cancel();
      } else {
        timeLeft--;
        notifyListeners();
      }
    });
    //resolve landing
  }

  void playerPressedRoll() {
    timer.cancel();
    rollDice();

    startTurn();
    //for timer constants make a pre-made option e.g., fast mode, regular
    //  OR make each timer customizable, action, buy, trade, etc.
    //and show interval

    //  turn structure
    //start actions timer
    //  let player make actions
    //  buy, sell, mortgage, trade
    //timer out: roll OR player rolls: cut timer
    //move player to new spot
    //resolve landing action: buy, pay, chance, jail, etc
    //on buy: start buying timer

    //another timer for purchase, or post actions
  }

  void rollDice() {
    //set top of que state to rolling?
    int die1 = _game.roll;
    int die2 = _game.roll;

    //set doubles to false
    if (die1 == die2) {
      if (_rollAttempt == 2) {
        //go to jail
        _game.sendPlayerToJail(currentPlayer.id);
        _rollAttempt = 0;
        _updateCurrentPlayer();
        //pass to ui
      } else {
        //regular move
        _game.advancePlayer(currentPlayer.id, die2 + die1);
        //go again
        _rollAttempt++;
        //pass to ui
      }
      //set doubles to true
    } else {
      _game.advancePlayer(currentPlayer.id, die2 + die1);
      // resolveLanding(currentPlayerPosition, currentPlayerPosition + die2 + die1);
      //add timer/ animation to match time
      //pass to ui
      _rollAttempt = 0;
      _updateCurrentPlayer();
    }

    //after the roll we update our board
  }

  void resolveLanding(int oldPosition, int newPosition) {
    var tileType = _game.tileData[newPosition].group;

    // passed go, landing on it handled separately
    if (currentPlayerPosition > 0 && _oldPosition < 40) {
      //collect $200
      _pay(200, collector: currentPlayer.id);
    }

    if (tileType == 'special') {
      //not buyable
      SpecialTile tile = _game.tileData[newPosition];

      //landed on go
      if (tile.id == 0) {
        _pay(200, collector: currentPlayer.id);
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
        _pay(200, debtor: currentPlayer.id);
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
        _game.sendPlayerToJail(currentPlayerId);
      }
      //all special tiles covered
    } else {
      //landed on Property
      Property property = _game.tileData[newPosition];

      //If the property doesn't have an owner
      if (!property.hasOwner) {
        //if player can afford the property
        if (currentPlayer.money > property.cost) {
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
        if (currentPlayer.id != property.ownerId) {
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
              Land land = _game.tileData[newPosition];
              //check if land has houses
              if (land.hasHouses) {
                _pay(land.rentWithHouses,
                    collector: land.ownerId, debtor: currentPlayer.id);
              }
              //if owner has all from group
              else if (1 == 2) {
                _pay(land.rent * 2,
                    collector: land.ownerId, debtor: currentPlayer.id);
              }
              //regular rent
              _pay(land.rent,
                  collector: land.ownerId, debtor: currentPlayer.id);
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
    if (collector > -1) _game.payMoney(collector, amount);
    if (debtor > -1) _game.collectMoney(debtor, amount);
    //notify each player in the UI
  }
}
