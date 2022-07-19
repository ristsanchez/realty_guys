import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerDisplay extends ChangeNotifier {
  int timeLeft;

  TimerDisplay() : timeLeft = 0;

  void tick() {
    timeLeft--;
    notifyListeners();
  }
}
