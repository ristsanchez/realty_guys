import 'package:flutter/foundation.dart';

class PurchaseProvider extends ChangeNotifier {
  late bool _landedOnProperty;
  late bool _buttonVisibility;

  bool get purchaseVisibility => _buttonVisibility;
  bool get ifCanBuy => _landedOnProperty;
  PurchaseProvider()
      : _landedOnProperty = true,
        _buttonVisibility = false;

  void landedOnProperty() {
    _landedOnProperty = true;
    _buttonVisibility;
    notifyListeners();
  }

  void toggleVisibility() {
    _buttonVisibility = !_buttonVisibility;
    //if true relaunch dialog? A: not here
    notifyListeners();
  }
}
