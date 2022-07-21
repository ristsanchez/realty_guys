import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/models/die.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/color_constants.dart';

class RollDiceDialog extends StatelessWidget {
  const RollDiceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
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

  DiceAnim()
      : die1 = 1,
        die2 = 1,
        old1 = 1,
        old2 = 1;
  init() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      while (die1 == old1) {
        die1 = die.roll;
      }
      old1 = die1;

      while (die2 == old2) {
        die2 = die.roll;
      }
      old2 = die2;

      if (timer.tick >= 16) {
        //set them to original val when initially rolled

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
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: DieFace(number: instance.die1)),
                const SizedBox(width: 20),
                Center(child: DieFace(number: instance.die2)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DieFace extends StatelessWidget {
  const DieFace({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    Widget temp = const Icon(Icons.question_mark_rounded);
    if (number == 6) {
      temp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot(), Dot()],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot(), Dot()],
          ),
        ],
      );
    }
    if (number == 5) {
      temp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot()],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot()],
          ),
        ],
      );
    }
    if (number == 4) {
      temp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot()],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Dot(), Dot()],
          ),
        ],
      );
    }
    if (number == 3) {
      temp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Dot(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Dot(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Dot(),
            ],
          ),
        ],
      );
    }
    if (number == 2) {
      temp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Dot(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Dot(),
            ],
          ),
        ],
      );
    }
    if (number == 1) {
      temp = Column(
          mainAxisAlignment: MainAxisAlignment.center, children: const [Dot()]);
    }
    return Container(
        padding: const EdgeInsets.all(8),
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: temp);
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
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
