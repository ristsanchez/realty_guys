import 'package:flutter/foundation.dart';

class BoardUIProvider extends ChangeNotifier {
  bool _showCosts;
  bool _showRolls;
  int _quarterTurns;

  bool get costVisibility => _showCosts;
  bool get rollsVisibility => _showRolls;

  int get rotations => _quarterTurns;

  BoardUIProvider()
      : _showCosts = false,
        _showRolls = false,
        _quarterTurns = 0;

  void toggleCostsVisibility() {
    _showCosts = !_showCosts;
    notifyListeners();
  }

  void toggleOwnerVisibility() {
    _showRolls = !_showRolls;
    notifyListeners();
  }

  void rotateBoard() {
    _quarterTurns++;
    if (_quarterTurns > 3) _quarterTurns = 0;
    notifyListeners();
  }
}
