import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:realty_guys/dialogs/index.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/models/tile.dart';
import 'package:realty_guys/providers/purchase_ui_provider.dart';

///Game Controller for local 'pass and play' (single device)
class GameController extends ChangeNotifier {
  Game game;

  bool isGameGoing;
  //game data

  Purchase purchase = Purchase();

  Player currentPlayer;
  int currentPlayerId;

  int _rollAttempt;

  late Timer timer;
  late int timeLeft;
  final int timeLimit;

  late int _oldPosition; //???wait

  Board get board => game.board;

  List get tileData => game.tileData;

  Set<Player> get playerInfo => game.players;

  int get currentPosition => game.playerPosition(currentPlayer.id);

  String get currentPlayerName => game.playerName(currentPlayer.id);

  GameController(this.game)
      : isGameGoing = false,
        _rollAttempt = 0,
        currentPlayerId = 0,
        currentPlayer = game.playerById(0),
        timeLeft = 0,
        //final values, from settings
        timeLimit = game.timeLimit;

  HashMap<int, Map> get playerIcons {
    HashMap<int, Map> temp = HashMap();
    for (Player player in game.players) {
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
    currentPlayerId %= game.numberOfPlayers;
    currentPlayer = game.playerById(currentPlayerId);
    notifyListeners();
  }

  void startGame() {
    isGameGoing = true;
    game.init();
    startTurn();
    notifyListeners();
  }

  void pauseGame() {
    timer.cancel();
  }

  void resumeGame() {}

  void startTurn() {
    timeLeft = game.timeLimit;

    //user can trade/sell/buy, etc
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timeLeft <= 0) {
        //cancel current actions, buying, selling, trading etc.
        playerPressedRoll();
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
    int die1 = game.roll;
    int die2 = game.roll;

    //dice animation here

    //set doubles to false
    if (die1 == die2) {
      if (_rollAttempt == 2) {
        //go to jail
        game.sendPlayerToJail(currentPlayer.id);
        _rollAttempt = 0;
        _updateCurrentPlayer();
        //pass to ui
      } else {
        //regular move
        passedGo(currentPosition, currentPosition + die2 + die1);

        game.advancePlayer(currentPlayer.id, die2 + die1);

        resolveLanding();
        //go again
        _rollAttempt++;
        //pass to ui
      }
      //set doubles to true
    } else {
      //check if passed go, then
      passedGo(currentPosition, currentPosition + die2 + die1);

      game.advancePlayer(currentPlayer.id, die2 + die1);

      resolveLanding();

      //reset roll attempt, and update who's current player
      _rollAttempt = 0;
      _updateCurrentPlayer();
    }
    //after the roll we update our board
  }

  //pay 200 if player passes or lands on the Go tile
  void passedGo(int oldPosition, int newPosition) {
    if (oldPosition < 40 && newPosition >= 0) {
      //collect $200
      _pay(200, collector: currentPlayer.id);
    }
  }

  void resolveLanding() {
    //Landed on a non-property tile
    if (game.tileData[currentPosition] is SpecialTile) {
      SpecialTile tile = game.tileData[currentPosition];

      //excluded because they do nothing
      //0: Go, 10: JustVisiting, 20: FreeParking(for now)
      //landed on chance tile
      if (tile.name == 'Chance') {
        //get random chance card and resolve effect
      } else if (tile.name == 'Lucky') {
        //get random lucky card and resolve effect
      }
      //landed on an income/luxury tax tile
      else if (tile.id == 4 || tile.id == 38) {
        _pay(200, debtor: currentPlayer.id); //pay 200 to bank (no one)
      }
      //landed on go to jail
      else if (tile.id == 30) {
        game.sendPlayerToJail(currentPlayerId); //send to jail tile
      }
    }
    if (game.tileData[currentPosition] is Property) {
      //landed on Property
      Property property = game.tileData[currentPosition];

      //If the property doesn't have an owner
      if (!property.hasOwner) {
        //if player can afford the property
        if (currentPlayer.money > property.cost) {
          //enable buy option in the UI
          // showBuyDialog(context, data)
          //turn on purchase provider with this data

          // await player input
          var playerSelectedBuy;
          if (playerSelectedBuy) {
            game.playerBuys(currentPlayerId, currentPosition);
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
              Land land = game.tileData[currentPosition];
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
    if (collector > -1) game.payMoney(collector, amount);
    if (debtor > -1) game.collectMoney(debtor, amount);
    //notify each player in the UI
  }
}
