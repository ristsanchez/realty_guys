import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/presentation/board_components/center_components/possible_landings.dart';
import 'package:realty_guys/presentation/board_components/center_components/property_owners.dart';
import 'package:realty_guys/providers/board_ui_provider.dart';

class InnerRingStack extends StatelessWidget {
  const InnerRingStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardUIProvider>(
      builder: ((context, boardUIProvider, child) {
        bool ifShowPrice = boardUIProvider.costVisibility;
        bool ifShowRolls = boardUIProvider.rollsVisibility;

        //Stack places widgets from back->front of the screen
        return Stack(
          children: [
            Visibility(visible: ifShowPrice, child: const PropertyOwners()),
            Visibility(visible: ifShowRolls, child: const RingRolls()),
            //more settings here
          ],
        );
      }),
    );
  }
}
