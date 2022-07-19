import 'package:flutter/foundation.dart';

class BoardUIProvider extends ChangeNotifier {
  bool _showCosts;
  bool _showOwner;
  int _quarterTurns;

  bool get costVisibility => _showCosts;
  bool get ownerVisibility => _showOwner;

  int get rotations => _quarterTurns;

  BoardUIProvider()
      : _showCosts = false,
        _showOwner = false,
        _quarterTurns = 0;

  void toggleCostsVisibility() {
    _showCosts = !_showCosts;
    notifyListeners();
  }

  void toggleOwnerVisibility() {
    _showOwner = !_showOwner;
    notifyListeners();
  }

  void rotateBoard() {
    _quarterTurns++;
    if (_quarterTurns > 3) _quarterTurns = 0;
    notifyListeners();
  }
}
