import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/icon_selection.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/game_settings.dart';
import 'package:realty_guys/presentation/views/board_screen.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/providers/game_controller.dart';
import 'package:realty_guys/providers/game_settings_provider.dart';
import 'package:realty_guys/models/luck_card.dart';
import 'package:realty_guys/models/player.dart';
import 'package:realty_guys/utils/json_utils.dart';

class GameSettingsScreen extends StatelessWidget {
  const GameSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Column(
          children: [mainBody(context), IconSelectorPanel()],
        ));
  }

  mainBody(BuildContext context) {
    const double opacity = 0.5;
    return ChangeNotifierProvider(
      create: (context) => GameSettingsProvider(),
      builder: (context, child) {
        return Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white10,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SizedBox(
                      height: 30,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Name',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: buttonWhenDataReady(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Opacity(
                              opacity: opacity,
                              child: IconButton(
                                  onPressed: () {
                                    Provider.of<GameSettingsProvider>(context,
                                            listen: false)
                                        .randomize();
                                  },
                                  icon: const Icon(Icons.casino)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Opacity(
                                  opacity: opacity,
                                  child: IconButton(
                                    onPressed: () {
                                      Provider.of<GameSettingsProvider>(context,
                                              listen: false)
                                          .previousIcon();
                                    },
                                    icon:
                                        const Icon(Icons.skip_previous_rounded),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Selector<GameSettingsProvider, Icon>(
                                    selector: (_, settings) =>
                                        settings.currentIcon,
                                    builder: (_, icon, child) => icon,
                                  ),
                                ),
                                Opacity(
                                  opacity: opacity,
                                  child: IconButton(
                                    onPressed: () {
                                      Provider.of<GameSettingsProvider>(context,
                                              listen: false)
                                          .nextIcon();
                                    },
                                    icon: const Icon(Icons.skip_next_rounded),
                                  ),
                                ),
                              ],
                            ),
                            Opacity(
                              opacity: opacity,
                              child: IconButton(
                                  onPressed: () {
                                    Provider.of<GameSettingsProvider>(context,
                                            listen: false)
                                        .changeColor();
                                  },
                                  icon: const Icon(Icons.color_lens_rounded)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
