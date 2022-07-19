import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/game_controller.dart';

class BoardActionsBar extends StatelessWidget {
  const BoardActionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double btnSize = 40;

    List<dynamic> buttonsRow = [
      const Icon(Icons.casino),
      const Icon(Icons.compare_arrows_rounded),
      Icon(Icons.add_home_outlined, color: Colors.green.shade200),
      const Icon(Icons.list_alt_rounded, color: Colors.redAccent),
      const Icon(Icons.account_balance, color: Colors.greenAccent),
      Stack(children: [
        Icon(Icons.add_home_outlined, color: Colors.red.shade200),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12),
          child:
              Icon(Icons.remove_circle, color: Colors.red.shade200, size: 12),
        )
      ]),
    ];
    List<Widget> temp = [];
    for (var i = 0; i < buttonsRow.length; i++) {
      temp.add(
        Container(
          height: btnSize,
          width: btnSize,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              primary: Colors.transparent,
            ),
            onPressed: () {
              switch (i) {
                case 0:
                  Provider.of<GameController>(context, listen: false)
                      .playerPressedRoll();
                  break;
                // case 'trade':
                // case 'buy':
                // case 'mort':
                // case 'unMort':
                // case 'sell':
                //   break;
              }
            },
            child: buttonsRow[i],
          ),
        ),
      );
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: temp);
  }
}
