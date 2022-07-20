import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/die.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/card_widgets/property_card_widget.dart';
import 'package:realty_guys/presentation/color_constants.dart';

class RollDiceDialog extends StatelessWidget {
  const RollDiceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop(true);
    });
    double boardSide = (MediaQuery.of(context).size.width - 20) / 7;
    return Dialog(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          top: boardSide + BoardConstraints.topRowPadding + 10,
          left: (boardSide + 10) + 10,
          right: (boardSide + 10) + 10,
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          constraints: BoardConstraints.cardConstraints(
              MediaQuery.of(context).size.width),
          child: const DiceView(),
        ));
  }
}

class DiceAnim extends ChangeNotifier {
  Die die = Die();
  late Timer timer;
  late int die1, die2;
  late int old1, old2;
  List nums = [1, 2, 3, 4, 5, 6];

  DiceAnim()
      : die1 = 1,
        die2 = 1,
        old1 = 1,
        old2 = 1;
  init() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      while (die1 == old1) {
        die1 = die.roll;
      }
      old1 = die1;

      if (timer.tick >= 10) {
        die1 += 200;
        timer.cancel();
      }
      notifyListeners();
    });
  }
}

class DiceView extends StatelessWidget {
  const DiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiceAnim>(
      create: (context) => DiceAnim()..init(),
      child: Consumer<DiceAnim>(
        builder: (context, instance, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('${instance.die1}')],
          );
        },
      ),
    );
  }
}

showRollDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.dialogBarrier,
      context: context,
      builder: (_) {
        return const RollDiceDialog();
      });
}
