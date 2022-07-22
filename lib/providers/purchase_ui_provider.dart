import 'package:flutter/foundation.dart';

class Purchase extends ChangeNotifier {
  bool purchaseState;

  bool buttonVisibility;

  bool purchaseCompleted; //----------this

  bool get purchaseVisibility => buttonVisibility;

  bool get ifCanBuy => purchaseState;

  Purchase()
      : purchaseState = true,
        purchaseCompleted = false,
        buttonVisibility = false;

  void resetPurchase() {
    //for the controller to call either after timer or after purchase completion;
  }

  void enablePurchase() {
    purchaseState = true;
    buttonVisibility = true;
    notifyListeners();
    //tile data from game prov,  index from current position
  }

  void toggleVisibility() {
    //on dismiss dialog nothing happens
    //on button press, relaunch dialog
    //this behavior is done at the ui level, no nee for provider class

    buttonVisibility = !buttonVisibility;
    //if true relaunch dialog? A: not here
    notifyListeners();
  }

  //this notifies game player pressed purchased button
  void acceptPurchase() {
    purchaseCompleted = true;
    notifyListeners();
  }
}
