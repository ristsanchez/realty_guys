import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/dialogs/roll_dialog.dart';
import 'package:realty_guys/presentation/board_components/actions_bar.dart';
import 'package:realty_guys/presentation/board_components/activated_actions_bar.dart';
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

    return Scaffold(
      // backgroundColor: AppColors.baseGray,
      body: Consumer<GameController>(
        builder: (context, gameController, child) {
          return Column(
            children: [
              Visibility(
                visible: gameController.isGameGoing,
                replacement: const SizedBox(height: 4),
                child: LinearProgressIndicator(
                  value: gameController.timeLeft / 30,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    10, gameController.isGameGoing ? 0 : 4, 10, 10),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<BoardUIProvider>(
                        create: (_) => BoardUIProvider()),
                    ChangeNotifierProvider(create: (_) => gameController.board),
                  ],
                  child: Column(
                    children: [
                      const BoardTopBar(),
                      //Move this to a separate class called boardStack
                      Selector<BoardUIProvider, int>(
                          selector: (_, boardUI) => boardUI.rotations,
                          builder: (context, rotations, child) {
                            return Container(
                              color: AppColors.backBoard,
                              //make this dimension constant
                              //width stays constant
                              height: maxX - 20,
                              child: RotatedBox(
                                quarterTurns: rotations,
                                child: Stack(
                                  children: const [
                                    BoardFoundation(), //board background
                                    //from getBoard(context, propertyData, rotations),

                                    PlayersLayer(),
                                    //this moved ^_playerPiecesOnBoard(context, 4 - rotations),
                                    MovementLayer(), //tbi
                                    //moved this ^ to a single method below lightUpTile(context, maxX - 20),

                                    //maybe the tile info layer on top of everything
                                    // so user can click without touching pieces
                                  ],
                                ),
                              ),
                            );
                          }),
                      const Divider(
                        height: 2,
                      ),
                      Visibility(
                        visible: gameController.isGameGoing,
                        child: const BoardActionsBar(),
                      ),
                      const Divider(height: 2),
                      Visibility(
                          visible: gameController.isGameGoing,
                          child: const PlayerInfoBar()),
                      const Divider(height: 2),
                      const PropertyAction(), //visible only if
                      Visibility(
                        visible: !gameController.isGameGoing,
                        child: ElevatedButton(
                          onPressed: () {
                            //init game
                            // Provider.of<GameController>(context, listen: false)
                            //     .startGame();
                            showRollDialog(context);
                          },
                          child: const Text('Start game'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
