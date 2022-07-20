import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';

import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/presentation/layout/online_layout.dart';
import 'package:realty_guys/presentation/views/board_screen.dart';
import 'package:realty_guys/presentation/views/components/icon_selection.dart';
import 'package:realty_guys/presentation/views/components/players_panel.dart';
import 'package:realty_guys/presentation/views/components/settings_panel.dart';
import 'package:realty_guys/providers/game_controller.dart';
import 'package:realty_guys/utils/json_utils.dart';

class HostView extends StatelessWidget {
  const HostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.baseGray,
      body: ClientHostLayout(children: [
        TiTitle(),
        InitGame(),
        SettingsPanel(),
        IconSelectorPanel(),
        PlayersConnectedPanel(),
      ]),
    );
  }
}

class TiTitle extends StatelessWidget {
  const TiTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: const Text(
        'Host Game',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white60,
        ),
      ),
    );
  }
}

class InitGame extends StatelessWidget {
  const InitGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                'Room Code: ',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              Text(
                '4325',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          FutureBuilder(
            future: Future.wait([
              JsonUtils.getPropertyData(),
              JsonUtils.getLuckyCardsData('chance'),
              JsonUtils.getLuckyCardsData('lucky'),
              JsonUtils.tempPlayers(),
            ]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> data = snapshot.data;
                return ElevatedButton(
                  onPressed: () =>
                      _goToGame(context, data[0], data[1], data[3]),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white38),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text('Start'),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(color: Colors.teal[200]));
              }
            },
          ),
        ],
      ),
    );
  }
}

void _goToGame(BuildContext context, List<dynamic> tileData,
    List<LuckCard> chanceCardData, HashSet<Player> players) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: ((BuildContext context) {
      GameSettings settings = GameSettings();
      Game newGame =
          Game(tileData, chanceCardData, chanceCardData, players, settings);

      return ChangeNotifierProvider<GameController>(
        create: (BuildContext context) => GameController(newGame),
        child: const BoardScreen(),
      );
    })),
  );
}
