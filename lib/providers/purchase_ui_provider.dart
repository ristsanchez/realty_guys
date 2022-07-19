import 'package:flutter/foundation.dart';

class Purchase extends ChangeNotifier {
  bool _purchaseState;

  bool _buttonVisibility;

  late bool _purchaseCompleted; //----------this

  bool get purchaseVisibility => _buttonVisibility;

  bool get ifCanBuy => _purchaseState;

  Purchase()
      : _purchaseState = true, // testing default false
        _buttonVisibility = false;

  void landedOnProperty() {
    _purchaseState = true;
    _buttonVisibility;
    notifyListeners();
  }

  void toggleVisibility() {
    _buttonVisibility = !_buttonVisibility;
    //if true relaunch dialog? A: not here
    notifyListeners();
  }

  //this notifies game player pressed purchased button
  void purchase() {
    _purchaseCompleted = true;
    notifyListeners();
  }
}
