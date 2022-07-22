import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/dialogs/roll_dialog.dart';
import 'package:realty_guys/models/board.dart';
import 'package:realty_guys/models/game.dart';
import 'package:realty_guys/presentation/board_components/actions_bar.dart';
import 'package:realty_guys/presentation/board_components/activated_actions_bar.dart';
import 'package:realty_guys/presentation/board_components/board_available.dart';
import 'package:realty_guys/presentation/board_components/board_foundation.dart';
import 'package:realty_guys/presentation/board_components/top_bar.dart';
import 'package:realty_guys/presentation/board_components/board_player_info_widget.dart';
import 'package:realty_guys/presentation/views/board_screen.dart';
import 'package:realty_guys/presentation/board_components/board_ui_movement.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';
import 'package:realty_guys/providers/game_controller.dart';

//this will be named board view
// this should be the actual board ui class, the layout will be the board screen class
//where ill organize the layout based on device sizes
class BoardLayout extends StatelessWidget {
  const BoardLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //initialize this at app start, or at layout build.
    final double maxX = MediaQuery.of(context).size.width;
    final double maxY = MediaQuery.of(context).size.height;

    //final variables
    //read once to get object instance, e.g., game instance for CN provider
    //or to get final value, game settings timer limit (stays the same)
    final Game game = Provider.of<GameController>(context, listen: false).game;
    final int timerLimit =
        Provider.of<GameController>(context, listen: false).timeLimit;

    //notified when changed, implemented at provider level
    bool ifGameOn = Provider.of<GameController>(context).isGameGoing;

    int timeLeft = Provider.of<GameController>(context, listen: false).timeLeft;

    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: ifGameOn,
            replacement: const SizedBox(height: 4), //keep size constant
            child: LinearProgressIndicator(value: timeLeft / timerLimit),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<BoardUIProvider>(
                      create: (_) => BoardUIProvider()),
                  ChangeNotifierProvider.value(value: game),
                ],
                builder: (context, child) {
                  int rotations =
                      Provider.of<BoardUIProvider>(context).rotations;
                  return Column(
                    children: [
                      const BoardTopBar(),
                      //Move this to a separate class called boardStack
                      Container(
                        color: AppColors.backBoard,
                        //make this dimension constant
                        //width stays constant
                        height: maxX - 20,
                        // width: maxX - 20,
                        child: RotatedBox(
                          quarterTurns: rotations,
                          child: Stack(
                            children: const [
                              BoardFoundation(), //board background
                              //from getBoard(context, propertyData, rotations),

                              PlayersLayer(),
                              //this moved ^_playerPiecesOnBoard(context, 4 - rotations),
                              // MovementLayer(), //tbi
                              //moved this ^ to a single method below lightUpTile(context, maxX - 20),
                              // AvailableProps(),
                              //maybe the tile info layer on top of everything
                              // so user can click without touching pieces
                            ],
                          ),
                        ),
                      ),

                      const Divider(
                        height: 2,
                      ),
                      Visibility(
                        visible: ifGameOn,
                        child: const BoardActionsBar(),
                      ),
                      const Divider(height: 2),
                      Visibility(
                          visible: ifGameOn, child: const PlayerInfoBar()),
                      const Divider(height: 2),
                      const PropertyAction(), //visible only if
                      Visibility(
                        visible: !ifGameOn,
                        child: ElevatedButton(
                          onPressed: () {
                            //init game
                            Provider.of<GameController>(context, listen: false)
                                .startGame();
                          },
                          child: const Text('Start game'),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
