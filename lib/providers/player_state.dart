import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PlayerState extends ChangeNotifier {
  late String currentState;
  final List<String> state = [
    'idle',
    'build',
    'sell',
    'mortgage',
    'unmortgage',
  ];

  PlayerState();

  //depending on the state the ui will hide/show certain functionality
  // set state() {}
}

///top layer of the board stack depending on the player current action
class ActionsLayout extends StatelessWidget {
  const ActionsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerState, String>(
      selector: (_, playerState) => playerState.currentState,
      builder: (_, state, child) {
        switch (state) {
          case 'idle':
            // property info layer
            return const Center();
          case 'build':
            // board available tiles with current's player available
            // tiles and each with an action.
            return const Center();
          case 'sell':
            return const Center();
          case 'mortgage':
            return const Center();
          case 'unmortgage':
            return const Center();
          default:
            return const Center();
        }
      },
    );
  }
}
