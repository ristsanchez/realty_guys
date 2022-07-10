import 'package:flutter/foundation.dart';

class BoardProvider extends ChangeNotifier {
  bool tempButton;
  bool _showCosts;

  bool get temp => tempButton;

  bool get costs => _showCosts;

  BoardProvider()
      : _showCosts = false,
        tempButton = true;

  void toggleCostsVisibility() {
    _showCosts = !_showCosts;
    notifyListeners();
  }

  void setTemp() {
    tempButton = !tempButton;
    notifyListeners();
  }
}
