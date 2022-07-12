import 'dart:math';

class Die {
  final Random _randomGenerator;

  Die() : _randomGenerator = Random();

  int roll() {
    // return int between (inclusive) 1 and 6
    return 1 + _randomGenerator.nextInt(6);
  }
}
