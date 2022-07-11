import 'package:flutter/foundation.dart';

class BoardProvider extends ChangeNotifier {
  int _currentTile;
  bool _showCosts;
  bool _showOwner;

  int get index => _currentTile;
  bool get costVisibility => _showCosts;
  bool get ownerVisibility => _showOwner;

  BoardProvider()
      : _showCosts = false,
        _showOwner = false,
        _currentTile = -1;

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
}
