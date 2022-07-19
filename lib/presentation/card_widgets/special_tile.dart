import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/models/tile.dart';

class TileInfoCard extends StatelessWidget {
  const TileInfoCard({Key? key, required this.tileData}) : super(key: key);
  final dynamic tileData;

  @override
  Widget build(BuildContext context) {
    //to ignore constraints wrap in expanded
    //find better way to do this

    return Container(
      decoration: tileData.name == 'Jail'
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: const [.33, .66],
                colors: [AppColors.jail, AppColors.base2],
              ),
            )
          : BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppColors.getColorFromName(tileData.name),
            ),
      constraints: BoardConstraints.slimCardConstraints(
          MediaQuery.of(context).size.width),
      child: _getSpecialTileCard(),
    );
  }

  Widget _getSpecialTileCard() {
    SpecialTile tile = tileData;
    Widget temp = const Center();
    if (tile.name == 'Chance') {
      temp = const Center(
          child: Icon(
        Icons.question_mark_rounded,
        size: 38,
      ));
    } else if (tile.name == 'Lucky') {
      temp = const Center(
        child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.question_mark_rounded,
            size: 45,
          ),
        ),
      );
      var temp2 = Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                Icons.question_mark_rounded,
                size: 40,
                color: AppColors.lucky,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                'replace this',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.luckyText,
                ),
              )),
        ],
      );
    } else if (tile.name == 'Income Tax') {
      temp = Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payments,
              size: 45,
              color: AppColors.payments,
            ),
            const SizedBox(width: 10),
            const Text(
              'Pay \$200',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      );
    } else if (tile.name == 'Luxury Tax') {
      temp = Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.toll,
              size: 45,
              color: AppColors.toll,
            ),
            const SizedBox(width: 10),
            const Text(
              'Pay \$200',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      );
    } else if (tile.id == 0) {
      //Go tile
      temp = Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'GO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Collect \$200',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white70),
          ),
        ],
      ));
    } else if (tile.id == 10) {
      temp = Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Just',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white70),
                  ),
                  Text(
                    'Visiting',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.join_right,
                size: 40,
              ),
            ),
            const Expanded(
              flex: 1,
              child: Text(
                'Jail',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else if (tile.id == 20) {
      temp = const Center(
        child: Icon(
          Icons.directions_bike_rounded,
          size: 65,
        ),
      );
    } else if (tile.id == 30) {
      temp = Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Go to Jail',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.sports_gymnastics_rounded,
                size: 60,
              ),
            ),
          ],
        ),
      );
    }

    return temp;
  }
}
