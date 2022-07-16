import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/board.dart';
import 'package:realty_guys/board_screen.dart';
import 'package:realty_guys/board_ui_provider.dart';
import 'package:realty_guys/die.dart';
import 'package:realty_guys/game.dart';
import 'package:realty_guys/json_util_data.dart';
import 'package:realty_guys/game_settings_provider.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({Key? key}) : super(key: key);

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: mainBody(context),
    );
  }

  @override
  void initState() {
    super.initState();
    //init json data? after first build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GameSettings>(context, listen: false).init();
    });
  }
}

loading() {
  return Center(child: CircularProgressIndicator(color: Colors.teal[200]));
}

mainBody(BuildContext context) {
  bool isGameInit = Provider.of<GameSettings>(context, listen: true).isInit;
  Icon currentIcon =
      Provider.of<GameSettings>(context, listen: true).currentIcon;
  HashMap<int, dynamic> data =
      Provider.of<GameSettings>(context, listen: true).data;
  const double opacity = 0.5;
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
                    child: isGameInit
                        ? ElevatedButton(
                            onPressed: () {
                              _goToGame(context, data);
                            },
                            child: const Text('Go?'),
                          )
                        : loading(),
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
                              Provider.of<GameSettings>(context, listen: false)
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
                                Provider.of<GameSettings>(context,
                                        listen: false)
                                    .previousIcon();
                              },
                              icon: const Icon(Icons.skip_previous_rounded),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(0),
                              child: currentIcon),
                          Opacity(
                            opacity: opacity,
                            child: IconButton(
                              onPressed: () {
                                Provider.of<GameSettings>(context,
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
                              Provider.of<GameSettings>(context, listen: false)
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
}

  void _goToGame(BuildContext context) {
    HashMap<int, dynamic> tileData =
        Provider.of<GameSettings>(context, listen: false).tileData;
    List<LuckCard> chanceCardData =
        Provider.of<GameSettings>(context, listen: false).chanceCards;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((BuildContext context) => MultiProvider(
              providers: [
                //Board ui provider, user interface settings
                ChangeNotifierProvider<BoardUIProvider>(
                    create: (_) => BoardUIProvider()),
                //
                //Board provider, provider players locations, movement functions
                ChangeNotifierProvider<Board>(create: (_) => Board()),
                //
                //ProxyProvider, init a board instance to be controlled by Game
                ChangeNotifierProxyProvider<Board, Game>(
                    create: (BuildContext context) => Game(
                          Provider.of<Board>(context, listen: false),
                          tileData,
                          chanceCardData,
                          chanceCardData,
                          players,
                        )..initGame(),
                    update: (BuildContext context, Board board, Game? game) {
                      game?.board = board;
                      return game ??
                          Game(board, tileData, chanceCardData, chanceCardData,
                              players);
                    }),
              ],
              child: BoardScreen(propertyData: tileData),
            )),
      ),
    );
  }
}
