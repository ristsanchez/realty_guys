import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';
import 'package:realty_guys/providers/game_controller.dart';

class BoardTopBar extends StatelessWidget {
  const BoardTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<GameController, String>(
              selector: (_, gameController) => gameController.currentPlayerName,
              builder: (_, player, child) {
                return Text("$player's turn");
              },
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Selector<GameController, int>(
              selector: (_, gameController) => gameController.timeLeft,
              builder: (_, timerValue, child) {
                return Text('$timerValue');
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<BoardUIProvider>(context, listen: false)
                  .toggleCostsVisibility();
            },
            child: Selector<BoardUIProvider, bool>(
              selector: (_, boardUIProvider) => boardUIProvider.costVisibility,
              builder: (context, showCosts, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: showCosts ? Colors.white24 : Colors.white10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      showCosts
                          ? Icons.attach_money_rounded
                          : Icons.money_off_rounded,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<BoardUIProvider>(context, listen: false)
                  .toggleOwnerVisibility();
            },
            child: Selector<BoardUIProvider, bool>(
              selector: (_, boardUIProvider) => boardUIProvider.rollsVisibility,
              builder: (context, showOwner, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: showOwner ? Colors.white24 : Colors.white10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      showOwner
                          ? Icons.remove_red_eye_outlined
                          : Icons.horizontal_rule_rounded,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<BoardUIProvider>(context, listen: false)
                  .rotateBoard();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Icon(
                  Icons.rotate_90_degrees_cw_rounded,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
