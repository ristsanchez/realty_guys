import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/presentation/layout/online_layout.dart';
import 'package:realty_guys/presentation/views/components/icon_selection.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/presentation/views/board_screen.dart';
import 'package:realty_guys/presentation/views/components/join_room_bar.dart';
import 'package:realty_guys/presentation/views/components/players_panel.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/providers/game_controller.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/utils/json_utils.dart';

class ClientSettingsView extends StatelessWidget {
  const ClientSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.baseGray,
      body: ClientHostLayout(children: [
        Center(
          child: Text('Join Game',
              style: TextStyle(fontSize: 22, color: Colors.white70)),
        ),
        JoinBar(),
        IconSelectorPanel(),
        PlayersConnectedPanel(),
      ]),
    );
  }

  buttonWhenDataReady() {
    return FutureBuilder(
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
              onPressed: () => goToGame(context, data[0], data[1], data[3]),
              child: const Text('Go'));
        } else {
          return Center(
              child: CircularProgressIndicator(color: Colors.teal[200]));
        }
      },
    );
  }

  void goToGame(BuildContext context, List<dynamic> tileData,
      List<LuckCard> chanceCardData, HashSet<Player> players) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((BuildContext context) {
        //more args from settings later
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
}
