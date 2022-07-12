import 'package:flutter/foundation.dart';

class BoardUIProvider extends ChangeNotifier {
  int _currentTile;
  bool _showCosts;
  bool _showOwner;
  int _quarterTurns;

  int get index => _currentTile;
  bool get costVisibility => _showCosts;
  bool get ownerVisibility => _showOwner;

  int get rotations => _quarterTurns;

  BoardUIProvider()
      : _showCosts = false,
        _showOwner = false,
        _currentTile = -1,
        _quarterTurns = 0;

  void increase() {
    _currentTile++;
    _currentTile %= 40;
    notifyListeners();
  }

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
